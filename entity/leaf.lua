local anim8 = require "lib/anim8"
local class = require "lib/middleclass"
local cache = require "cache"

local Entity = require "entity/entity"
local Leaf = class("Leaf", Entity)

function Leaf:initialize(world, x, y, w, h)
  Entity.initialize(self, world, x, y, w, h)

  local leafImg = cache:getOrLoadImage("asset/leaf.png")
  self.leafParticle = love.graphics.newParticleSystem(leafImg, 5)
  self.leafParticle:setParticleLifetime(5)
  self.leafParticle:setEmissionRate(2)
  self.leafParticle:setAreaSpread("uniform", w, 0)
  self.leafParticle:setLinearAcceleration(0, 50, 0, 50)
  self.leafParticle:setColors(255, 255, 255, 255, 255, 255, 255, 255)
end

function Leaf:update(dt)
  self.leafParticle:update(dt)
end

function Leaf:draw()
  love.graphics.draw(self.leafParticle, self.x, self.y)
end

return Leaf
