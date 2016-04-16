function love.conf(t)
  t.console = true

  t.window.title = 'LDJAM 35'
  t.window.width = 1280
  t.window.height = 720
  t.window.minwidth = 1280
  t.window.minheight = 720
  t.window.resizable = false

  t.modules.joystick = false
  t.modules.physics = false
end
