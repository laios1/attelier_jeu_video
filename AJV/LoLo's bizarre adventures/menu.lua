local menu = {}

btPlayF = function ()
  currentScene = sceneListe.t1
  currentScene.reset()
end 



function menu.load()
  btPlay = btRect(btPlayF,love.graphics.getWidth()/2-100,love.graphics.getHeight()/2-100,200,100,"push","play",{1,0.5,0},{0,0,0})
end 

menu.load()

function menu.update(dt)
  btPlay.update(dt)
end 

function menu.draw()
  btPlay.draw()
end 

function menu.keypressed(key)
  if key == "enter" then
    btPlayF()
  end 
end 


return menu