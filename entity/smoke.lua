local anim8 = require "lib/anim8"
local class = require "lib/middleclass"
local cache = require "cache"

local Entity = require "entity/entity"
local Smoke = class("Smoke", Entity)

function Smoke:initialize(world, x, y, w, h)
  Entity.initialize(self, world, x, y, w, h)

  local img = cache:getOrLoadImage("asset/smoke.png")
  self.smokeParticle = love.graphics.newParticleSystem(img, 5)
  self.smokeParticle:setParticleLifetime(1)
  self.smokeParticle:setEmissionRate(5)
  self.smokeParticle:setPosition(w / 2, 0)
  self.smokeParticle:setAreaSpread("uniform", w / 2, 0)
  self.smokeParticle:setLinearAcceleration(0, -50, 0, -50)
  self.smokeParticle:setEmitterLifetime(2)
  self.smokeParticle:setColors(255, 255, 255, 255, 255, 255, 255, 100)
end

function Smoke:start()
  self.smokeParticle:start()
end

function Smoke:pause()
  self.smokeParticle:pause()
end

function Smoke:update(dt)
  self.smokeParticle:update(dt)
end

function Smoke:draw()
  love.graphics.draw(self.smokeParticle, self.x, self.y)
end

return Smoke
