require("MapEtClasses")

local map2 = {}






function map2.reset()

  map2.map = Map(33,23,32)
  
  player.x, player.y = 17,12
  player.but = {player.x,player.y}


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