io.stdout:setvbuf('no')
require("FuGrEtTa") -- pour l'instant on en a pas vraiment besoin mais tbprint est utile au debeugage
require("gui")
require("MapEtClasses")

love.graphics.setBackgroundColor(0.5,0.5,0.5)
love.window.setMode(700,600)



debugMode = false 
---------------------------------------------- images
tree = love.graphics.newImage("images/arbre.png")
KIOU = love.graphics.newImage("images/rock.png")
bonhom = love.graphics.newImage("images/bonomheu.png")
door = love.graphics.newImage("images/porte.png")

---------------------------------------------- add scenes 
sceneListe = {}
sceneListe.menu = require('menu')
sceneListe.t1 = require('tuto1')
sceneListe.t2 = require('tuto2')

----------------------------------------------

player = Player(100,4,4,bonhom,4,1,5,2)

----------------------------------------------

currentScene = sceneListe.menu-- a mettre menu / c fait owo

function love.update(dt)
  currentScene.update(dt)
end 

function love.draw()
  currentScene.draw()
end 



function love.keypressed(key)
  if key == "t" then 
    if debugMode then
      debugMode = false
    else
      debugMode = true 
    end 
  end 
  
  if key == "escape" then
    love.event.quit("restart")
  end 
end 