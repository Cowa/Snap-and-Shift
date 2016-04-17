local anim8 = require "lib/anim8"
local class = require "lib/middleclass"
local cache = require "cache"

local Entity = require "entity/entity"
local Gold = class("Gold", Entity)

function Gold:initialize(world, x, y, w, h)
  Entity.initialize(self, world, x, y, w, h)

  local img = cache:getOrLoadImage("asset/gold.png")
  self.goldParticle = love.graphics.newParticleSystem(img, 5)
  self.goldParticle:setParticleLifetime(1)
  self.goldParticle:setEmissionRate(5)
  self.goldParticle:setPosition(w / 2, -10)
  self.goldParticle:setAreaSpread("uniform", w / 2, 0)
  self.goldParticle:setLinearAcceleration(-10, -100, -10, -100)
  self.goldParticle:setEmitterLifetime(2)
  self.goldParticle:setColors(255, 255, 255, 255, 255, 255, 255, 100)
end

function Gold:start()
  self.goldParticle:start()
end

function Gold:pause()
  self.goldParticle:pause()
end

function Gold:update(dt)
  self.goldParticle:update(dt)
end

function Gold:draw()
  love.graphics.draw(self.goldParticle, self.x, self.y)
end

return Gold
