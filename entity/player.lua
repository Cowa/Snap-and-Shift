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
  self.isOnGround = false

  local futureX = self.x + dt * self.vx
  local futureY = self.y + dt * self.vy

  local actualX, actualY, cols, len = self.world:move(self, futureX, futureY, self.filter)

  _.each(cols, function (i, e)
    self:checkIfOnGround(e.normal.y)
  end)

  self.x = actualX
  self.y = actualY
end

function Player:filter(other)
  if other:isInstanceOf(Block)
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
  if love.keyboard.isDown("right") then
    self.vx = self.speed

  elseif love.keyboard.isDown("left") then
    self.vx = -self.speed

  else
    self.vx = 0
  end

  if love.keyboard.isDown("up") and self.isOnGround then
    self:doJump()
  end
end

function Player:doJump(dt)
  self.vy = -self.jumpVelocity
end

function Player:draw()
  love.graphics.draw(self.img, self.x, self.y)
  self.camera:draw()
end

return Player
