local menu = {}

local btPlayF = function ()
  currentScene = sceneListe.t1
end 

local btPlay = btRect(btPlayF,love.graphics.getWidth()/2-100,love.graphics.getHeight()/2-100,200,100,"push","play",{1,0.5,0},{0,0,0})


function menu.update(dt)
  btPlay.update(dt)
end 

function menu.draw()
  btPlay.draw()
end 


return menu