local class = require "lib/middleclass"

local Entity = require "entity/entity"
local Block = class("Block", Entity)

function Block:initialize(world, x, y, w, h)
  Entity.initialize(self, world, x, y, w, h)
end

return Block
