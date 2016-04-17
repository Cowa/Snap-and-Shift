local class = require "lib/middleclass"
local anim8 = require "lib/anim8"
local cache = require "cache"

local Gold = require "entity/gold"
local Shiftable = require "entity/shiftable"
local Checkpoint = class("Checkpoint", Shiftable)

function Checkpoint:initialize(world, x, y, w, h, properties)
  Shiftable.initialize(self, world, x, y, w, h, properties)

  self.img = cache:getOrLoadImage("asset/checkpoint.png")
  self.sound = cache:getOrLoadSound("asset/sound/checkpoint.wav")

  local g = anim8.newGrid(77, 103, self.img:getWidth(), self.img:getHeight())
  self.notCrossedAnimation = anim8.newAnimation(g('1-1', 1), 1)

  g = anim8.newGrid(77, 103, self.img:getWidth(), self.img:getHeight(), 77, 0)
  self.crossedAnimation = anim8.newAnimation(g('1-1', 1), 1)

  -- one use (once crossed by player)
  self.used = false

  self.crossedParticle = Gold:new(world, self.x, self.y, self.w, self.h)
  self.crossedParticle:pause()
end

function Checkpoint:update(dt)
  self.crossedParticle:update(dt)
end

function Checkpoint:shift()
  self.shifted = not self.shifted
end

function Checkpoint:crossedByPlayer()
  self.used = true
  self.crossedParticle:start()
  self.sound:play()
end


function Checkpoint:draw()
  self.crossedParticle:draw()
  if not self.used then
    self.notCrossedAnimation:draw(self.img, self.x, self.y)
  else
    self.crossedAnimation:draw(self.img, self.x, self.y)
  end
end

return Checkpoint
