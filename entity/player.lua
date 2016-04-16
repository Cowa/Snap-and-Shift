local _ = require "lib/moses"
local anim8 = require "lib/anim8"
local class = require "lib/middleclass"
local cache = require "cache"

local Entity = require "entity/entity"

local Player = class("Player", Entity)

function Player:initialize(world, x, y)
  Entity.initialize(self, world, x, y, 64, 64)
  self.speed = 150
  self.jump = 500
end

function Player:update(dt)
  self:changeVelocityByInput(dt)
  self:changeVelocityByGravity(dt)
  self:move(dt)
end

function Player:move(dt)
  local futureX = self.x + self.vx * dt
  local futureY = self.y + self.vy * dt

  local actualX, actualY, cols, len = self.world:move(self, futureX, futureY, self.filter)

  self.x = actualX
  self.y = actualY


  _.map(cols, function (i, o)
    if o.other.class.name == "Stuff" then
      -- do something
    end
  end)
end

function Player:filter(other)
  local kind = other.class.name
  if kind == "Block" then
    return "slide"
  end
end

function Player:changeVelocityByGravity(dt)
  self.vy = self.vy + self.gravity * dt
end

function Player:changeVelocityByInput(dt)
  if love.keyboard.isDown("right") then
    self.vx = self.speed
    self.position = "right"

  elseif love.keyboard.isDown("left") then
    self.vx = -self.speed
    self.position = "left"

  else
    self.vx = 0
    self.position = "stand"
  end

  if love.keyboard.isDown("up") then
    self.vy = -self.jump
    self.position = "swim"

  elseif love.keyboard.isDown("down") then
    self.vy = self.jump

  else
    self.vy = 0
  end
end

function Player:draw()
  love.graphics.setColor(255, 255, 255, 255)
  love.graphics.rectangle("fill", self.x, self.y, self.w, self.h)
end

return Player
