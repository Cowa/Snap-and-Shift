local class = require "lib/middleclass"

local Entity = require("entity/entity")
local Exit = class("Exit", Entity)

function Exit:initialize(world, x, y, w, h)
  Entity.initialize(self, world, x, y, w, h)
end


function Exit:update(dt)

end

return Exit
