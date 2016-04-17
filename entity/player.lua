local _ = require "lib/moses"
local anim8 = require "lib/anim8"
local class = require "lib/middleclass"
local cache = require "cache"

local Entity = require "entity/entity"
local Block = require "entity/block"
local BlockingShiftable = require "entity/blocking-shiftable"

local Player = class("Player", Entity)

function Player:initialize(world, x, y, camera)
  Entity.initialize(self, world, x, y, 64, 100)

  self.speed = 200
  self.gravity = 600
  self.jumpVelocity = 400

  self.img = cache:getOrLoadImage("asset/player.png")

  local g = anim8.newGrid(92, 100, self.img:getWidth(), self.img:getHeight())
  self.animation = anim8.newAnimation(g('1-1', 1), 1)
  self.standingAnimation = self.animation

  g = anim8.newGrid(92, 100, self.img:getWidth(), self.img:getHeight(), 92, 0)
  self.takingPhotoAnimation = anim8.newAnimation(g('1-1', 1), 1)

  self.facing = "right"

  -- by default first position of player
  self.lastCheckpoint = { x = x, y = y }

  self.die = false
  self.crossedExit = false

  self.camera = camera
end

function Player:update(dt)
  self:changeVelocityByGravity(dt)
  self:changeVelocityByInput(dt)
  self:move(dt)

  self.camera:update(dt)
end

function Player:checkIfOnGround(ny)
  if ny < 0 then
    self.isOnGround = true
  end
end

function Player:moveCamera(x, y)
  local distance = math.dist(x, y, self.x, self.y)

  -- cannot move camera too far from player
  --if distance > 350 then return end

  self.camera:move(x, y)
end

function Player:mousePressed(x, y, button)
  if button == 1 then
    self.camera:takePhoto()
  end
end

function Player:move(dt)
  if self.die then
    self:toLastCheckPoint()
    self.die = false
    return
 end

  self.isOnGround = false

  local futureX = self.x + dt * self.vx
  local futureY = self.y + dt * self.vy

  local actualX, actualY, cols, len = self.world:move(self, futureX, futureY, self.filter)

  _.each(cols, function (i, e)
    if e.other.class.name == "Checkpoint" and not e.other.used then
      self.lastCheckpoint = e.other
      e.other:crossedByPlayer()

    elseif e.other.class.name == "Water" then
      self.die = true

    elseif e.other.class.name == "Exit" then
      self.crossedExit = true

    elseif e.other:isInstanceOf(Block)
        or e.other:isInstanceOf(BlockingShiftable) then
      self:checkIfOnGround(e.normal.y)
    end
  end)

  self.x = actualX
  self.y = actualY
end

function Player:toLastCheckPoint()
  self.x, self.y = self.lastCheckpoint.x, self.lastCheckpoint.y
  self.world:update(self, self.x, self.y, self.w, self.h)
end

function Player:filter(other)
  if other.class.name == "Checkpoint"
  or other.class.name == "Water"
  or other.class.name == "Exit" then
    return "cross"

  elseif other:isInstanceOf(Block)
      or other:isInstanceOf(BlockingShiftable)
      and not other.removed
  then
    return "slide"

  end
end

function Player:changeVelocityByGravity(dt)
  if self.isOnGround then
    self.vy = 0

  else
    self.vy = self.vy + self.gravity * dt
  end
end

function Player:changeVelocityByInput(dt)
  if love.keyboard.isDown("right")
  or love.keyboard.isDown("d") then
    self.vx = self.speed
    self.facing = "right"

  elseif love.keyboard.isDown("left")
  or love.keyboard.isDown("q")
  or love.keyboard.isDown("a") then
    self.vx = -self.speed
    self.facing = "left"

  else
    self.vx = 0
  end

  if (love.keyboard.isDown("up")
  or love.keyboard.isDown("z")
  or love.keyboard.isDown("w"))
  and self.isOnGround then
    self:doJump()
  end
end

function Player:doJump(dt)
  self.vy = -self.jumpVelocity
end

function Player:draw()
  local takingPhoto = self.camera.takingPhoto
  if takingPhoto then
    self.animation = self.takingPhotoAnimation
  else
    self.animation = self.standingAnimation
  end

  if self.facing == "left" then
    self.animation:flipH()
    self.animation:draw(self.img, self.x - 28, self.y)
    self.animation:flipH()

  else
    self.animation:draw(self.img, self.x, self.y)
  end
end

return Player
