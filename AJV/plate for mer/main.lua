width = 800
height = 600

require("player")
require("platform")

function restart()
  player.restart()
  platform.restart()
end 


function love.update(dt)
  platform.onGround()
  player.update(dt)
end

function love.draw()
  love.graphics.setBackgroundColor(0,50,150)
  player.draw()
  platform.draw()
end 


function love.keypressed(key)
  if key == "escape" then 
    --love.event.quit()
    restart()
  end 
  player.jump(key)
end 