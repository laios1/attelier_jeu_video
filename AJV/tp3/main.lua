
function love.load()
love.window.setMode(1024,768,{resizable = true})
scx = 1 

angle = 0 
Vit_angle = 3
scale = 0
Vit_scl = 1
  
DVD = love.graphics.newImage("image/DVD.png")
largeurDVD = DVD:getWidth()
hauteurDVD = DVD:getHeight()


  
end 


function love.draw()
--  love.graphics.draw(DVD,0,0,0,0.5,0.5)
--  love.graphics.draw(DVD,largeur,0,0,0.5,0.5,largeurDVD,0)
--  love.graphics.draw(DVD,0,hauteur,0,0.5,0.5,0,hauteurDVD)
--  love.graphics.draw(DVD,largeur,hauteur,0,0.5,0.5,largeurDVD,hauteurDVD)
--  love.graphics.draw(DVD,largeur/2,hauteur/2,0,0.5,0.5,largeurDVD/2,hauteurDVD/2)
love.graphics.draw(DVD,largeur/2,hauteur/2,0,scx,1,largeurDVD/2,hauteurDVD/2)

end 


function love.update(dt)
  scx = -scx
largeur = love.graphics.getWidth()
hauteur = love.graphics.getHeight()
end