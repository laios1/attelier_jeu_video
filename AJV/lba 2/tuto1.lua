require("MapEtClasses")

local map1 = {}


map1.map = Map(7,6,100)

 


--------------------- porte 
function porteUpdt(dt,ox,oy)
  if ( math.floor(player.x) == ox  or math.ceil(player.x) == ox ) and ( player.y == oy  or math.ceil(player.y) == oy ) then
    player.x, player.y = 4,6
    player.but = {player.x,player.y}
    currentScene = sceneListe.t2
  end 
end 

map1.map.list[4][1] = objStatique(door,porteUpdt,"door")
--map1.map.list[5][1] = objStatique(door,porteUpdt,"door")
--------------------

for i = 1,3 do
  for j = 1,4 do 
    map1.map.list[i][j] = objStatique(tree)
  end 
end 
for i = 1,3 do
  for j = 1,4 do 
    map1.map.list[8-i][j] = objStatique(tree)
  end 
end 
for i = 1,7 do
  for j = 1,2 do 
    map1.map.list[i][7-j] = objStatique(KIOU)
  end 
end 



function map1.setup()
  
end 

function map1.update(dt)
  map1.map.update(dt)
  player.update(dt,map1.map)
end 

function map1.draw()
  map1.map.draw(dt)
  player.draw()
end 


return map1