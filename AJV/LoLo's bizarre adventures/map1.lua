require("MapEtClasses")
local map1 = {}
local tree = love.graphics.newImage("images/etmerde.png")

map1.mapTest = Map(5,5,50)

local function move(obj)
  local step = 0 
  local function updtt()
    if step < 16 then
      obj.y = obj.y + 0.25
      step = step + 1 
    elseif step < 32 then
      obj.x = obj.x + 0.25
      step = step + 1 
    elseif step < 48 then
      obj.y = obj.y - 0.25
      step = step + 1 
    elseif step < 64 then
      obj.x = obj.x - 0.25
      step = step + 1 
    else 
      step = 0 
    end 
  end 
  return updtt
end 
map1.mapTest.add(objOuPnj(0,0,tree,move,10))



function map1.update(dt)
  map1.mapTest.update(dt)
end 


function map1.draw()
  map1.mapTest.draw()
end 

return map1 