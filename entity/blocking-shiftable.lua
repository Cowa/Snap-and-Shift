local class = require "lib/middleclass"

local Shiftable = require "entity/shiftable"
local BlockingShiftable = class("BlockingShiftable", Shiftable)

function BlockingShiftable:initialize(world, x, y, w, h, properties)
  Shiftable.initialize(self, world, x, y, w, h, properties)
end

return BlockingShiftable
