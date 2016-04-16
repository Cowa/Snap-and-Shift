local class = require "lib/middleclass"
local anim8 = require "lib/anim8"
local cache = require "cache"

local Shiftable = require "entity/shiftable"
local Bush = class("Bush", Shiftable)

function Bush:initialize(world, x, y, w, h, properties)
  Shiftable.initialize(self, world, x, y, w, h, properties)

  self.img = cache:getOrLoadImage("asset/bush.png")

  local g = anim8.newGrid(262, 136, self.img:getWidth(), self.img:getHeight())
  self.notShiftedImg = anim8.newAnimation(g('1-1', 1), 1)

  g = anim8.newGrid(262, 136, self.img:getWidth(), self.img:getHeight(), 262, 0)
  self.shiftedImg = anim8.newAnimation(g('1-1', 1), 1)
end

function Bush:shift()
  self.shifted = not self.shifted
end

function Bush:draw()
  if self.shifted then
    self.shiftedImg:draw(self.img, self.x, self.y)

  else
    self.notShiftedImg:draw(self.img, self.x, self.y)
  end
end

return Bush
