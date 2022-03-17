scene_liste = {}
largeur, hauteur = love.graphics.getDimensions()
function love.load()
  bg = love.graphics.newImage("BG_intro.jpg")
  bggo = love.graphics.newImage("BG_Gameover.png")
end
scene_liste.intro = require("scene_Intro")
scene_liste.game = require("scene_game")
scene_liste.GO = require("scene_GameOver")


currentScene = scene_liste.intro



function love.update(dt)
  currentScene.update(dt)
end


function love.draw()
  currentScene.draw()
end 

function love.keypressed(key)
  currentScene.keypressed(key)
end