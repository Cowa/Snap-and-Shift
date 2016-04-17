require "util"

local Game = require "game"
local GameState = require "lib/gamestate"

function love.load()
  math.randomseed(os.time())
  love.keyboard.setKeyRepeat(true)

  GameState.registerEvents()
  GameState.switch(Game)
end

function love.update(dt)
  love.window.setTitle("Snap & Shift | " .. love.timer.getFPS() .. " FPS")

  GameState.current():update(dt)

  if love.keyboard.isDown("escape") then
    love.event.quit()
  end
end

function love.mousepressed(x, y, button)
  GameState.current():mousePressed(x, y, button)
end

function love.draw()
  GameState.current():draw()
end

function love.resize(w, h)

end
