local _ = require "lib/moses"
local class = require "lib/middleclass"
local tween = require "lib/tween"
local cache = require "cache"

local Entity = require "entity/entity"
local Camera = class("Camera", Entity)
local Shiftable = require "entity/shiftable"

-- Camera which take pictures (not game camera!!)
function Camera:initialize(world, x, y, w, h)
  Entity.initialize(self, world, x, y, w, h)

  self.flash = {
    opacity = 0,
    color = { 232, 232, 200 }
  }
  self.flashIn = tween.new(0.50, self.flash, { opacity = 200 })
  self.flashOut = tween.new(0.50, self.flash, { opacity = 0 })

  self.takingPhoto = false

  self.img = cache:getOrLoadImage("asset/camera.png")
  self.sound = cache:getOrLoadSound("asset/sound/camera.wav")
end

function Camera:takePhoto()
  -- cannot mitraillette photos
  if self.takingPhoto then return end

  self.sound:play()
  local items, len = self.world:queryRect(self.x, self.y, self.w, self.h, filter)

  _.each(items, function (i, e) e:shift() end)

  self.takingPhoto = true
end

function filter(other)
  if other:isInstanceOf(Shiftable) then
    return true
  end
end

function Camera:update(dt)
  if self.takingPhoto then
    local isFlashInDone = self.flashIn:update(dt)

    if isFlashInDone then
      local isFlashOutDone = self.flashOut:update(dt)

      if isFlashOutDone then
        self.flashOut:reset()
        self.flashIn:reset()
        self.takingPhoto = false
      end
    end
  end
end

function Camera:draw()
  --love.graphics.setColor(255, 0, 100, 255)
  --love.graphics.rectangle("line", self.x, self.y, self.w, self.h)
  love.graphics.draw(self.img, self.x, self.y)

  love.graphics.setColor(self.flash.color[1], self.flash.color[2], self.flash.color[3], self.flash.opacity)
  love.graphics.rectangle("fill", self.x, self.y, self.w, self.h)
end

function Camera:move(x, y)
  local middleX, middleY = x - (self.w / 2), y - (self.h / 2)

  self.world:update(self, middleX, middleY)

  self.x, self.y = middleX, middleY
end

return Camera
