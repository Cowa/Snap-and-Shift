local _ = require "lib/moses"
local sti = require "lib/sti"
local class = require "lib/middleclass"
local bump = require "lib/bump"
local cache = require "cache"
local tween = require "lib/tween"

local Camera = require "entity/camera"

local Menu = {}

function Menu:init()
  self.world = bump.newWorld(64)

  self.img = cache:getOrLoadImage("asset/menu.png")

  self.blackScreen = { opacity = 255 }
  self.enterIn = tween.new(2, self.blackScreen, { opacity = 0 })
  self.enterOut = tween.new(1, self.blackScreen, { opacity = 255 })

  -- camera photo used as pointer
  self.camera = Camera:new(self.world, 0, 0)

  self.clicked = false
end

function Menu:enter()
  love.mouse.setVisible(false)
end

function Menu:update(dt)
  self.enterIn:update(dt)

  local x, y = love.mouse.getPosition()

  self.camera:update(dt)
  self.camera:move(x, y)

  if self.clicked and not self.camera.takingPhoto then
    local ended = self.enterOut:update(dt)

    if ended then
      GameState.switch(Game)
    end
  end
end

function Menu:mousePressed(x, y, button)
  self.camera:takePhoto()
  self.clicked = true
end

function Menu:draw()
  love.graphics.draw(self.img, 0, 0)
  self.camera:draw()

  love.graphics.setColor(0, 0, 0, self.blackScreen.opacity)
  love.graphics.rectangle("fill", 0, 0, 1280, 720)
  love.graphics.setColor(255, 255, 255, 255)
end

return Menu
