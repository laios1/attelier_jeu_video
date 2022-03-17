scene_Game = {}


monHero = require("hero")

scene_Game.update = function(dt)
  monHero.move(dt)
  if monHero.x  < 0 or monHero.x > largeur or monHero.y < 0 or monHero.y > hauteur then 
    currentScene = scene_liste.GO
  end 
end

scene_Game.draw = function()
  monHero.show()
  love.graphics.print("DANS LE GAME !!!!!!!!!!!!!!!!!!", largeur/2, hauteur/2)
end

scene_Game.keypressed = function(key)
  if key == "space" then
    currentScene = scene_liste.intro
  end
end

return scene_Game