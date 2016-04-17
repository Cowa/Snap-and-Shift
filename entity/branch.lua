local class = require "lib/middleclass"
local anim8 = require "lib/anim8"
local cache = require "cache"

local BlockingShiftable = require "entity/blocking-shiftable"
local Branch = class("Branch", BlockingShiftable)

function Branch:initialize(world, x, y, w, h, properties)
  BlockingShiftable.initialize(self, world, x, y, w, h, properties)

  self.img = cache:getOrLoadImage("asset/branch.png")

  local g = anim8.newGrid(86, 108, self.img:getWidth(), self.img:getHeight())
  self.notShiftedImg = anim8.newAnimation(g('1-1', 1), 1)

  g = anim8.newGrid(302, 146, self.img:getWidth(), self.img:getHeight(), 86, 0)
  self.shiftedImg = anim8.newAnimation(g('1-1', 1), 1)

  self.flipped = properties["flipH"]

  if self.flipped then
    self.notShiftedImg:flipH()
    self.shiftedImg:flipH()
  end
end

function Branch:shift()
  self.shiftParticle:start()

  if not self.shifted then
    self.w = 287
    self.h = 116

    if self.flipped then
      self.x = self.x - 216
    end
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

function Branch:draw()
  if self.shifted then
    if not self.flipped then
      self.shiftedImg:draw(self.img, self.x, self.y - 15)

    else
      self.shiftedImg:draw(self.img, self.x - 12, self.y - 15)
    end
  else
    if not self.flipped then
      self.notShiftedImg:draw(self.img, self.x, self.y - 15)

    else
      self.notShiftedImg:draw(self.img, self.x - 12, self.y - 15)
    end
  end
  self.shiftParticle:draw()
end

return Branch
