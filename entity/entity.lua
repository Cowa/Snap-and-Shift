local class = require "lib/middleclass"

local Entity = class("Entity")

function Entity:initialize(world, x, y, w, h)
  self.world, self.x, self.y, self.w, self.h = world, x, y, w, h
  self.vx, self.vy = 0,0
  self.world:add(self, x, y, w, h)
  self.removed = false
  self.gravity = 6000
end

function Entity:remove()
  self.world:remove(self)
  self.removed = true
end

function Entity:filter(other)
  local kind = other.class.name
  if kind == 'Rock' then return 'slide' end
end

return Entity
