local class = require "lib/middleclass"

local Entity = require("entity/entity")
local Water = class("Water", Entity)

function Water:initialize(world, x, y, w, h)
  Entity.initialize(self, world, x, y, w, h)
end


function Water:update(dt)

end

return Water
