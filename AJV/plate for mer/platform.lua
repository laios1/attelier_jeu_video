platform = {}
platform.x = 400
platform.y = 300
platform.width = 200 
platform.height = 25
platform.friction = 10

function platform.collideTop(rect1,rect2)
  if rect1.x < rect2.x + rect2.width and rect1.x + rect1.width > rect2.x and rect1.y < rect2.y + rect2.height and rect1.y + rect1.height > rect2.y--[[and player.speedy >= 0]] then
    return true 
  end 
  return false
end 
  
  
Ground = {}
Ground.x = 0 
Ground.y = 400
Ground.width = 800
Ground.height = 200
Ground.friction = 10

platform.restart = function()
  Ground.x = 0 
  Ground.y = 400
  Ground.width = 800
  Ground.height = 200
  Ground.friction = 6 
end 

function platform.onGround()
  if platform.collideTop(player,platform) then
    player.onGround = true
    player.currentplatform = platform
  elseif player.y + player.height >= Ground.y then 
    player.onGround = true
    player.currentplatform = Ground
  else
    player.onGround = false
    player.currentplatform = nil 
  end 
end 

function platform.update(dt)
  
end 

function platform.draw()
  love.graphics.setColor(0.5,0.5,0.5)
  love.graphics.rectangle("fill", platform.x, platform.y, platform.width, platform.height)
  love.graphics.setColor( 0.1,0.7,0.2)
  love.graphics.rectangle("fill", Ground.x, Ground.y, Ground.width, Ground.height)
end 