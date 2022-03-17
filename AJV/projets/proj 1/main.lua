rond = {}
rond.x = 100
rond.y = 100
rond.r = 50 
love.window.setMode(800,600)

rond.draw = function()
  if IsIn() then
    love.graphics.setColor({1,1,1})
  else
    love.graphics.setColor({1,0,0})
  end
  love.graphics.circle("fill",rond.x,rond.y,rond.r)
end

function IsIn() 
--  if ((rond.x - love.mouse.getX())^2 + (rond.y - love.mouse.getY())^2)^0.5 < rond.r+srond.r then
--    return true
--  else
--  return false
--  end
  local pro = {}
  pro[1] = {rond.x - rond.r,rond.y}
  pro[2] = {rond.x + rond.r,rond.y}
  pro[3] = {rond.x,rond.y + rond.r}
  pro[4] = {rond.x,rond.y - rond.r}
  
  local pre = {}
  
  pre[1] = {rect.x,rect.y}
  pre[2] = {rect.x + rect.l ,rect.y}
  pre[3] = {rect.x, rect.y + rect.h}
  pre[4] = {rect.x + rect.l, rect.y + rect.h}
  for _,v in ipairs(pro) do
    if v[1] > rect.x and v[1] < rect.x + rectl and v[2] > rect.y and v[2] < rect.y + rectl  then
      return true
    end
  end
  for _,v in ipairs(pre) do
    if ((rond.x - v[1])^2 + (rond.y - v[2])^2)^0.5 < rond.r then
      return true
    end
  end
  return false
end 

srond = {}
srond.r = 20
srond.draw = function()
  love.graphics.setColor({0,0,1})
  love.graphics.circle("fill",love.mouse.getX(),love.mouse.getY(),srond.r)
end





rect = {}
rect.x = 300
rect.y = 400
rect.l = 300
rect.h = 60
rect.colorR = 40
rect.colorG = 90
rect.colorB = 0

rect2 = {}
rect2.l = 100
rect2.h = 400

rect.draw = function()
  love.graphics.setColor(rect.colorR,rect.colorG,rect.colorB)
  love.graphics.rectangle("fill",rect.x,rect.y,rect.l,rect.h)
  love.graphics.setColor(0,0,0)
  
end

rect2.draw = function()
  love.graphics.setColor(200,0,200)
  love.graphics.rectangle("fill",love.mouse.getX(),love.mouse.getY(),rect2.l,rect2.h)
  love.graphics.setColor(0,0,0)
end




--rect.isIn = function(x,y,ecart1,ecart2)
--  if x > rect.x+ecart1 and x < rect.x + rect.l and y > rect.y+ecart2 and y < rect.y+rect.h then
--    return true
--  else
--    return false
--    end
--end
function IsIn() 
--  if ((rond.x - love.mouse.getX())^2 + (rond.y - love.mouse.getY())^2)^0.5 < rond.r+srond.r then
--    return true
--  else
--  return false
--  end
  local pro = {}
  pro[1] = {rond.x - rond.r,rond.y}
  pro[2] = {rond.x + rond.r,rond.y}
  pro[3] = {rond.x,rond.y + rond.r}
  pro[4] = {rond.x,rond.y - rond.r}
  
  local pre = {}
  
  pre[1] = {rect.x,rect.y}
  pre[2] = {rect.x + rect.l ,rect.y}
  pre[3] = {rect.x, rect.y + rect.h}
  pre[4] = {rect.x + rect.l, rect.y + rect.h}
  for _,v in ipairs(pro) do
    if v[1] > rect.x and v[1] < rect.x + rectl and v[1] > rect.y and v[1] < rect.y + rectl  then
      return true
    end
  end
  for _,v in ipairs(pre) do
    if ((rond.x - v[1])^2 + (rond.y - v[2])^2)^0.5 < rond.r then
      return true
    end
  end
  return false
end 

rect.update = function(objetx,objety,ecart1,ecart2)
  if IsIn()  then
    rect.colorR = 40
    rect.colorG = 90
    rect.colorB = 100
  else
    rect.colorR = 40
    rect.colorG = 90
    rect.colorB = 0
  end
end






function love.update(dt)
  rect.update(love.mouse.getX(),love.mouse.getY(),-rect2.l,-rect2.h)
end 



function love.draw()
  if IsIn()  then
    love.graphics.setColor(1,0,0)
  else
    love.graphics.setColor(0,1,0)
  end
  rect2.draw()
  rond.draw()
end


