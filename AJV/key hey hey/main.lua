io.stdout:setvbuf('no')

bat = {} 
bat.x = 100
bat.y = 150
bat.sy = 1
bat.sx = -1
bat.vx = 0 
bat.vy = 0 
bat.move = function(det)
  bat.speedx = 0 
  bat.speedy = 0 
  
  if love.keyboard.isDown("d") then 
    bat.speedx = bat.speedx + 100 
    bat.sx = -1
  end 
  if love.keyboard.isDown("q") then 
    bat.speedx = bat.speedx - 100 
    bat.sx = 1
  end 
  if love.keyboard.isDown("s") then 
    bat.speedy = bat.speedy + 100 
  end 
  if love.keyboard.isDown("z") then 
    bat.speedy = bat.speedy - 100 
  end 
  
  if bat.speedx ~= 0 or bat.speedy ~= 0 then 
     bat.vy = bat.speedy/math.sqrt(bat.speedx^2+bat.speedy^2)*100
     bat.vx = bat.speedx/math.sqrt(bat.speedx^2+bat.speedy^2)*100
  end 
  
  bat.x = bat.x +  bat.vx*det
  bat.y = bat.y +  bat.vy*det
  
  bat.vx = 0 
  bat.vy = 0 
end 
bat.img = love.graphics.newImage("image/bat.png")
bat.w = bat.img:getWidth()
bat.h = bat.img:getHeight()



target = {}
target.x = 100
target.y = 150
target.img = love.graphics.newImage("image/target.png")
target.move = function(det)
  target.speedx = 0 
  target.speedy = 0 
  
  if love.keyboard.isDown("d") then 
    target.speedx = target.speedx + 100 
    target.sx = -1
  end 
  if love.keyboard.isDown("q") then 
    target.speedx = target.speedx - 100 
    target.sx = 1
  end 
  if love.keyboard.isDown("s") then 
    target.speedy = target.speedy + 100 
  end 
  if love.keyboard.isDown("z") then 
    target.speedy = target.speedy - 100 
  end 
  
  if target.speedx ~= 0 or target.speedy ~= 0 then 
     target.vy = target.speedy/math.sqrt(target.speedx^2+target.speedy^2)*100
     target.vx = target.speedx/math.sqrt(target.speedx^2+target.speedy^2)*100
  end 
  
  target.x = target.x +  target.vx*det
  target.y = target.y +  target.vy*det
  
  target.vx = 0 
  target.vy = 0 
end 



function love.draw()
  love.graphics.draw(bat.img,bat.x,bat.y,0,bat.sx,bat.sy,bat.w/2,bat.h/2)
end

function love.update(dt)
  bat.move(dt)
end 

function love.keypressed(key)
  print("la touche "..key.." vien d'etre enfoncer")
  if key == "escape" then 
    love.event.quit()
  end 
end 



function love.mousepressed(x,y,button)
  print("on a cliquer en "..x,y.."avec le boutton "..tostring(button))
end

function love.mousereleased(x,y,button)
  print("le boutton "..tostring(button).."vien d'etre relaché")
end

function love.wheelmoved(x,y)
  print("la roulette vien de tourner de (x,y) : "..tostring(x)..","..tostring(y))
end