require("MapEtClasses")

local map1 = {}





  

function map1.reset()
  player.x, player.y = 4,4
  player.but = {player.x,player.y}
  map1.map = Map(33,23,32)
  
  
  map1.map.list[4][1] = createPorte(sceneListe.t2,{4,6},"fantom")


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