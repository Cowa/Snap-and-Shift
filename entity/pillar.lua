local class = require "lib/middleclass"
local anim8 = require "lib/anim8"
local cache = require "cache"

local BlockingShiftable = require "entity/blocking-shiftable"
local Pillar = class("Pillar", BlockingShiftable)

function Pillar:initialize(world, x, y, w, h, properties)
  BlockingShiftable.initialize(self, world, x, y, w, h, properties)

  self.img = cache:getOrLoadImage("asset/pillar.png")

  local g = anim8.newGrid(103, 232, self.img:getWidth(), self.img:getHeight())
  self.notShiftedImg = anim8.newAnimation(g('1-1', 1), 1)

  g = anim8.newGrid(103, 232, self.img:getWidth(), self.img:getHeight(), 103, 0)
  self.shiftedImg = anim8.newAnimation(g('1-1', 1), 1)
end

function Pillar:shift()
  if not self.shiftable then return end

  if not self.shifted then
    self.w = 66
    self.h = 100

  else
    self.x = self.initial.x
    self.y = self.initial.y
    self.w = self.initial.w
    self.h = self.initial.h
  end

  self.world:update(self, self.x, self.y, self.w, self.h)

  self.shifted = not self.shifted
end

function Pillar:draw()
  if self.shifted then
    self.shiftedImg:draw(self.img, self.x - 20, self.y)

  else
    self.notShiftedImg:draw(self.img, self.x - 20, self.y)
  end
end

return Pillar
