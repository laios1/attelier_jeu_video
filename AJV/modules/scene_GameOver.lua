scene_GO = {}

hero = require("hero")

scene_GO.update = function(delta)
  
end 

function scene_GO.draw()
  love.graphics.draw(bggo,0,0)
  love.graphics.print("PRESS SPACE", 3/4*largeur,hauteur/2)
end

function scene_GO.keypressed(key)
  if key == "space" then
    currentScene = scene_liste.intro
    hero.x = 100
    hero.y = 100 
  end
end

return scene_GO