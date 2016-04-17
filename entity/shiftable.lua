local class = require "lib/middleclass"

local Entity = require "entity/entity"
local Shiftable = class("Shiftable", Entity)

function Shiftable:initialize(world, x, y, w, h, properties)
  Entity.initialize(self, world, x, y, w, h)
  self.properties = properties

  self.initial = {
    x = x, y = y, w = w, h = h
  }

  self.shiftable = properties["shiftable"]

  self.shifted = false

  if properties["shifted"] ~= nil then
    self.shifted = properties["shifted"]
  end
end

function Shiftable:shift()

end

function Shiftable:draw()

end

return Shiftable
