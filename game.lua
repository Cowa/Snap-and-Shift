local _ = require "lib/moses"
local sti = require "lib/sti"
local gamera = require "lib/gamera"
local class = require "lib/middleclass"
local bump = require "lib/bump"
local bump_debug = require "lib/bump_debug"
local cache = require "cache"
local tween = require "lib/tween"

local Player = require "entity/player"
local Block = require "entity/block"

local Game = {}

function Game:init()
  self.widthCamera = 1280
  self.heightCamera = 720

  self.widthWorld = 5000
  self.heightWorld = 2000

  self.camera = gamera.new(0, 0, self.widthWorld, self.heightWorld)
  self.camera:setWindow(0, 0, self.widthCamera, self.heightCamera)
  self.camera:setPosition(0, 0)

  self.world = bump.newWorld(64)

  self.map = sti.new("asset/game.lua")

  _.each(self.map.layers["blocks"].objects, function (i, e)
    Block:new(self.world, e.x, e.y, e.width, e.height)
  end)

  local p = self.map.layers["player"].objects[1]
  self.player = Player:new(self.world, p.x, p.y)
end

function Game:update(dt)
  self.map:update(dt)
  self.camera:setPosition(self.player.x, self.player.y)

  self.player:update(dt)
end

function Game:draw()
  self.camera:draw(function(l, t, w, h)
    self.map:draw()
    self.player:draw()
  end)
end

return Game
