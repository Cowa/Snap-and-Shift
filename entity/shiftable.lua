local class = require "lib/middleclass"

local Entity = require "entity/entity"
local Shiftable = class("Shiftable", Entity)

function Shiftable:initialize(world, x, y, w, h, properties)
  Entity.initialize(self, world, x, y, w, h)
  self.properties = properties

  self.initial = {
    x = x, y = y, w = w, h = h
  }

  self.shifted = false
end

function Shiftable:draw()
  love.graphics.setColor(0, 100, 255, 255)
  love.graphics.rectangle("fill", self.x, self.y, self.w, self.h)
end

function Shiftable:shift()
  if not self.shifted then
    self.h = self.h / 2

  else
    self.x = self.initial.x
    self.y = self.initial.y
    self.w = self.initial.w
    self.h = self.initial.h
  end

  self.world:update(self, self.x, self.y, self.w, self.h)

  self.shifted = not self.shifted
end

return Shiftable
