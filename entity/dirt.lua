local class = require "lib/middleclass"
local anim8 = require "lib/anim8"
local cache = require "cache"

local BlockingShiftable = require "entity/blocking-shiftable"
local Dirt = class("Dirt", BlockingShiftable)

function Dirt:initialize(world, x, y, w, h, properties)
  BlockingShiftable.initialize(self, world, x, y, w, h, properties)

  self.img = cache:getOrLoadImage("asset/dirt.png")

  local g = anim8.newGrid(88, 103, self.img:getWidth(), self.img:getHeight())
  self.notShiftedImg = anim8.newAnimation(g('1-1', 1), 1)

  g = anim8.newGrid(287, 308, self.img:getWidth(), self.img:getHeight(), 88, 0)
  self.shiftedImg = anim8.newAnimation(g('1-1', 1), 1)
end

function Dirt:shift()
  self.shiftParticle:start()

  if not self.shifted then
    self.w = 287
    self.h = 308
  else
    self.x = self.initial.x
    self.y = self.initial.y
    self.w = self.initial.w
    self.h = self.initial.h
  end

  self:updateParticle()
  self.world:update(self, self.x, self.y, self.w, self.h)

  self.shifted = not self.shifted
end

function Dirt:draw()
  if self.shifted then
    self.shiftedImg:draw(self.img, self.x, self.y)

  else
    self.notShiftedImg:draw(self.img, self.x, self.y)
  end

  self.shiftParticle:draw()
end

return Dirt
