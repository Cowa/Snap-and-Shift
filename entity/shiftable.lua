local class = require "lib/middleclass"

local Entity = require "entity/entity"
local Smoke = require "entity/smoke"
local Shiftable = class("Shiftable", Entity)

function Shiftable:initialize(world, x, y, w, h, properties)
  Entity.initialize(self, world, x, y, w, h)
  self.properties = properties

  self.initial = {
    x = x, y = y, w = w, h = h
  }

  self.shiftable = true

  if properties["shiftable"] ~= nil then
    self.shiftable = properties["shiftable"]
  end

  self.shiftable = properties["shiftable"]
  self.shifted = false

  if properties["shifted"] ~= nil then
    self.shifted = properties["shifted"]
  end

  self.shiftParticle = Smoke:new(world, self.x, self.y, self.w, self.h)
  self.shiftParticle:pause()
end

function Shiftable:update(dt)
  self.shiftParticle:update(dt)
end

function Shiftable:updateParticle()
  self.shiftParticle = Smoke:new(self.world, self.x, self.y, self.w, self.h)
end

function Shiftable:shift()

end

function Shiftable:draw()

end

return Shiftable
