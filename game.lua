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
local Camera = require "entity/camera"
local Barrel = require "entity/barrel"
local Pillar = require "entity/pillar"
local Branch = require "entity/branch"
local Dirt = require "entity/dirt"
local Bush = require "entity/bush"
local Checkpoint = require "entity/checkpoint"
local Water = require "entity/water"
local Shiftable = require "entity/shiftable"
local BlockingShiftable = require "entity/blocking-shiftable"

local Game = {}

function Game:init()
  self.widthCamera = 1280
  self.heightCamera = 720

  self.widthWorld = 5000
  self.heightWorld = 1440

  self.camera = gamera.new(0, 0, self.widthWorld, self.heightWorld)
  self.camera:setWindow(0, 0, self.widthCamera, self.heightCamera)
  self.camera:setPosition(0, 0)

  self.world = bump.newWorld(64)

  self.map = sti.new("asset/game.lua")

  _.each(self.map.layers["blocks"].objects, function (i, e)
    Block:new(self.world, e.x, e.y, e.width, e.height)
  end)

  self.pillars = _.map(self.map.layers["pillars"].objects, function (i, e)
    return Pillar:new(self.world, e.x, e.y, e.width, e.height, e.properties)
  end)

  self.barrels = _.map(self.map.layers["barrels"].objects, function (i, e)
    return Barrel:new(self.world, e.x, e.y, e.width, e.height, e.properties)
  end)

  self.branches = _.map(self.map.layers["branches"].objects, function (i, e)
    return Branch:new(self.world, e.x, e.y, e.width, e.height, e.properties)
  end)

  self.dirts = _.map(self.map.layers["dirts"].objects, function (i, e)
    return Dirt:new(self.world, e.x, e.y, e.width, e.height, e.properties)
  end)

  self.bushes = _.map(self.map.layers["bushes"].objects, function (i, e)
    return Bush:new(self.world, e.x, e.y, e.width, e.height, e.properties)
  end)

  self.checkpoints = _.map(self.map.layers["checkpoints"].objects, function (i, e)
    return Checkpoint:new(self.world, e.x, e.y, e.width, e.height, e.properties)
  end)

  self.water = _.map(self.map.layers["water"].objects, function (i, e)
    return Water:new(self.world, e.x, e.y, e.width, e.height, e.properties)
  end)

  local playerCamera = self.map.layers["camera"].objects[1]
  playerCamera = Camera:new(self.world, playerCamera.x, playerCamera.y, playerCamera.width, playerCamera.height)

  local p = self.map.layers["player"].objects[1]
  self.player = Player:new(self.world, p.x, p.y, playerCamera)
end

function Game:enter()
  love.mouse.setVisible(false)
end

function Game:update(dt)
  self.map:update(dt)
  self.camera:setPosition(self.player.x, self.player.y)

  self.player:update(dt)

  local x, y = love.mouse.getPosition()
  x, y = self.camera:toWorld(x, y)

  self.player:moveCamera(x, y)

  _.each(self.pillars, function (i, s) s:update(dt) end)
  _.each(self.barrels, function (i, s) s:update(dt) end)
  _.each(self.branches, function (i, s) s:update(dt) end)
  _.each(self.dirts, function (i, s) s:update(dt) end)
  _.each(self.bushes, function (i, s) s:update(dt) end)
  _.each(self.checkpoints, function (i, s) s:update(dt) end)
  _.each(self.water, function (i, s) s:update(dt) end)
end

function Game:mousePressed(x, y, button)
  local x, y = love.mouse.getPosition()
  x, y = self.camera:toWorld(x, y)

  self.player:mousePressed(x, y, button)
end


function Game:draw()
  self.camera:draw(function(l, t, w, h)
    self.map:draw()
    _.each(self.pillars, function (i, s) s:draw() end)
    _.each(self.barrels, function (i, s) s:draw() end)
    _.each(self.branches, function (i, s) s:draw() end)
    _.each(self.dirts, function (i, s) s:draw() end)
    _.each(self.bushes, function (i, s) s:draw() end)
    _.each(self.checkpoints, function (i, s) s:draw() end)
    self.player:draw()
  end)
end

return Game
