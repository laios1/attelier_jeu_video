io.stdout:setvbuf('no')
dl = false
bat = {} 
bat.x = 100
bat.y = 150
bat.sy = 1
bat.sx = -1
bat.vx = 0
bat.vy = 0
bat.move = function(det)
  bat.x = bat.x + bat.vx*det
  bat.y = bat.y + bat.vy*det
end 
bat.img = love.graphics.newImage("image/batAnimated.png")
bat.nbFrame = 25 
bat.cFrame = 1
bat.w = bat.img:getWidth()/bat.nbFrame
bat.h = bat.img:getHeight()
bat.quad = love.graphics.newQuad(0,0,bat.w,bat.h,bat.img:getWidth(),bat.img:getHeight())
bat.anim = function()
  bat.quad = love.graphics.newQuad(bat.cFrame*bat.w,0,bat.w,bat.h,bat.img:getWidth(),bat.img:getHeight())
  if bat.cFrame == bat.nbFrame-1  then
    bat.cFrame = 0
  end
  bat.cFrame = bat.cFrame + 1
  print(bat.cFrame)
end 

target = {}
target.x = 100
target.y = 150
target.img = love.graphics.newImage("image/target.png")
target.w = target.img:getWidth()
target.h = target.img:getHeight()



function love.draw()
  
  love.graphics.draw(target.img,target.x,target.y,0,1,1,target.w/2,target.h/2)
  love.graphics.draw(bat.img,bat.quad,bat.x,bat.y,0,bat.sx,bat.sy,bat.w/2,bat.h/2)
  if dl then 
    love.graphics.setColor(1,1,1)
    love.graphics.line(bat.x,bat.y,love.mouse.getX(),love.mouse.getY())
  end
end

function love.update(dt)
  mouse()
  followTarget(bat,target)
  bat.move(dt)
  bat.anim()
end 


function followTarget(a,b)
  local di = laSainteDistance(a,b)
  local o = math.asin((b.y-a.y)/di)
  
  if b.x-a.x < 0 then
    o = math.pi-o
    a.sx = 1
  else
    a.sx = -1
  end
  if di  > 4 then
    a.vx = math.cos(o)*di*10 --200
    a.vy = math.sin(o)*di*10 --200
  else 
    a.vx = 0
    a.vy = 0
  end
end

function mouse()
    local mx,my = love.mouse.getPosition()
    dl = false
  if love.mouse.isDown(1) then 
    bat.x = mx
    bat.y = my
    dl = true 
    
  elseif love.mouse.isDown(2) then 
    target.x = mx
    target.y = my
  end
  
end

function love.keypressed(key)
  --print("la touche "..key.." vien d'etre enfoncer")
  if key == "escape" then 
    love.event.quit()
  end 
end 

function laSainteDistance(a,b)
  local dist = ((b.x-a.x)^2 + (b.y-a.y)^2)^0.5
  return dist
end


function love.mousepressed(x,y,button)
 -- print("on a cliquer en "..x,y.."avec le boutton "..tostring(button))
end

function love.mousereleased(x,y,button)
 -- print("le boutton "..tostring(button).." vien d'etre relaché")
end

function love.wheelmoved(x,y)
 -- print("la roulette vien de tourner de (x,y) : "..tostring(x)..","..tostring(y))
end