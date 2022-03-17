require("MapEtClasses")

local map2 = {}


map2.map = Map(7,6,100)




--------------------- porte 
function porteUpdt(dt,ox,oy)
  if ( math.floor(player.x) == ox  or math.ceil(player.x) == ox ) and (player.y == oy  or math.ceil(player.y) == oy ) then
  player.x, player.y = 4,4
  player.but = {player.x,player.y}
  currentScene = sceneListe.t1
  end 
end 

map2.map.list[4][1] = objStatique(door,porteUpdt,"door")
--map2.map.list[5][1] = objStatique(door,porteUpdt,"door")
--------------------


map2.map.list[2][2] = objStatique(KIOU,_,"movable")
map2.map.list[3][2] = objStatique(KIOU,_,"movable")
map2.map.list[5][2] = objStatique(KIOU,_,"movable")
map2.map.list[6][2] = objStatique(KIOU,_,"movable")

map2.map.list[3][3] = objStatique(KIOU,_,"movable")
map2.map.list[4][3] = objStatique(KIOU,_,"movable")
map2.map.list[5][3] = objStatique(KIOU,_,"movable")

map2.map.list[2][4] = objStatique(KIOU,_,"movable")
map2.map.list[6][4] = objStatique(KIOU,_,"movable")

map2.map.list[3][5] = objStatique(KIOU,_,"movable")
map2.map.list[4][5] = objStatique(KIOU,_,"movable")
map2.map.list[5][5] = objStatique(KIOU,_,"movable")

map2.map.list[2][1] = objStatique(tree)
map2.map.list[6][1] = objStatique(tree)

for j = 1,6 do
  map2.map.list[1][j] = objStatique(tree)
  map2.map.list[7][j] = objStatique(tree)
end 


function map2.update(dt)
  map2.map.update(dt)
  player.update(dt,map2.map)
end 

function map2.draw()
  map2.map.draw(dt)
  player.draw()
end 


return map2