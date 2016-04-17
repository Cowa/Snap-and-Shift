local class = require "lib/middleclass"
local anim8 = require "lib/anim8"
local cache = require "cache"

local Smoke = require "entity/smoke"
local BlockingShiftable = require "entity/blocking-shiftable"
local Barrel = class("Barrel", BlockingShiftable)

function Barrel:initialize(world, x, y, w, h, properties)
  BlockingShiftable.initialize(self, world, x, y, w, h, properties)

  self.img = cache:getOrLoadImage("asset/barrel.png")

  local g = anim8.newGrid(105, 112, self.img:getWidth(), self.img:getHeight())
  self.notShiftedImg = anim8.newAnimation(g('1-1', 1), 1)

  g = anim8.newGrid(193, 112, self.img:getWidth(), self.img:getHeight(), 105, 0)
  self.shiftedImg = anim8.newAnimation(g('1-1', 1), 1)

  if self.shifted then
    self.removed = true
  end
end

function Barrel:shift()
  self.shiftParticle:start()

  if not self.shifted then
    self.w = 195
    self.removed = true

  else
    self.x = self.initial.x
    self.y = self.initial.y
    self.w = self.initial.w
    self.h = self.initial.h
    self.removed = false
  end

  self:updateParticle()
  self.world:update(self, self.x, self.y, self.w, self.h)

  self.shifted = not self.shifted
end

function Barrel:draw()
  if self.shifted then
    self.shiftedImg:draw(self.img, self.x, self.y)

  else
    self.notShiftedImg:draw(self.img, self.x, self.y)
  end

  self.shiftParticle:draw()
end

return Barrel
