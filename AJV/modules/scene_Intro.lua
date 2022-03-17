scene_intro = {}

scene_intro.update = function(delta)
  
end 

function scene_intro.draw()
  love.graphics.draw(bg,0,0)
  love.graphics.print("PRESS SPACE", 3/4*largeur,hauteur/2)
end

function scene_intro.keypressed(key)
  if key == "space" then
    currentScene = scene_liste.game
  end
end

return scene_intro