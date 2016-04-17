local class = require "lib/middleclass"
local anim8 = require "lib/anim8"
local cache = require "cache"

local Shiftable = require "entity/shiftable"
local Checkpoint = class("Checkpoint", Shiftable)

function Checkpoint:initialize(world, x, y, w, h, properties)
  Shiftable.initialize(self, world, x, y, w, h, properties)

  self.img = cache:getOrLoadImage("asset/checkpoint.png")

  local g = anim8.newGrid(77, 103, self.img:getWidth(), self.img:getHeight())
  self.shiftedImg = anim8.newAnimation(g('1-1', 1), 1)
end

function Checkpoint:shift()
  self.shifted = not self.shifted
end

function Checkpoint:draw()
  self.shiftedImg:draw(self.img, self.x, self.y)
end

return Checkpoint
