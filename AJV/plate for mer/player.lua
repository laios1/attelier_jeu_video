player = {}
player.x = 50 
player.y = 50
player.width = 50 
player.height = 50 
player.forcex = 0
player.forcey = 0 
player.speedx = 0
player.speedy = 0 
player.accelerationx = 0
player.accelerationy = 0
player.runForce = 4000
player.jumpForce = 50000
player.onGround = false 
player.currentplatform = nil
G = 1500


player.restart = function()
  player.x = 50 
  player.y = 50
  player.width = 50 
  player.height = 50 
  player.forcex = 0
  player.forcey = 0 
  player.speedx = 0
  player.speedy = 0 
  player.accelerationx = 0
  player.accelerationy = 0
  player.runForce = 4000
  player.jumpForce = 50000
  player.onGround = false 
  player.currentplatform = nil
  G = 1500
end 



player.addforce = function(forcex,forcey) 
  player.forcex = player.forcex + forcex
  player.forcey = player.forcey + forcey 
end 

player.gravity = function()
  player.addforce(0,G)
end

player.reaction = function()
  if player.onGround then 
    if player.speedx > 0 and player.speedy ~= 0  then
      player.addforce(-player.speedx,0) 
      player.speedx = 0
      player.x = player.currentplatform.x + player.currentplatform.width
      
    elseif player.speedx < 0 then
      player.addforce(-player.speedx,0) 
      player.speedx = 0
      player.x = player.currentplatform.x - player.width
    
    elseif player.speedy >= 0 then
      player.addforce(0,-G) 
      player.speedy = 0 
      player.y = player.currentplatform.y - player.height --player.y - player.speedy
      
    elseif player.speedy < 0 then
      player.addforce(0,G) 
      player.speedy = 0 
      player.y = player.currentplatform.y - player.currentplatform.height --player.y - player.speedy
      
    end 
  end 
end 

player.friction = function()
  if player.onGround then
    player.speedx = player.speedx - player.speedx / player.currentplatform.friction
  end 
end

player.jump = function(key)
  if key == "z" or key == "up" then 
    if player.onGround then
      player.addforce(0,-player.jumpForce) 
      player.onGround = false
    end 
  end 
end

player.run = function()
  if (love.keyboard.isDown("right") or love.keyboard.isDown("d")) and player.onGround then
    player.addforce(player.runForce,0)
  end 
  if (love.keyboard.isDown("left") or love.keyboard.isDown("q")) and player.onGround then
    player.addforce(-player.runForce,0)
  end 
end

player.sumforce = function()
  player.friction()
  player.gravity()
  player.reaction()
  player.run()
end 

player.update = function(dt)
  player.sumforce()
  player.accelerationx = player.forcex 
  player.accelerationy = player.forcey 
  
  
  player.speedx = player.speedx + player.accelerationx *dt
  player.speedy = player.speedy + player.accelerationy *dt
  
  player.x = player.x + player.speedx * dt
  player.y = player.y + player.speedy * dt
  
  player.forcex = 0
  player.forcey = 0 
end 

player.draw = function()
  love.graphics.setColor(0.9,0.1,0.1)
  love.graphics.rectangle("fill",player.x,player.y,player.width,player.height)
end 