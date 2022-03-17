io.stdout:setvbuf('no')
require("FuGrEtTa") -- pour l'instant on en a pas vraiment besoin mais tbprint est utile au debeugage
require("gui")
require("MapEtClasses")

love.graphics.setBackgroundColor(0.5,0.5,0.5)
love.window.setMode(1056,736)



debugMode = false 

----------------------------------------------------------------------------------------- dialogues
font = love.graphics.newFont(24)
love.graphics.setFont(font)
dialogueIsRunning = false
dialogue = Dialogue()
---------------------------------------------- images
tree = love.graphics.newImage("images/arbre.png")
KIOU = love.graphics.newImage("images/rock.png")
bonhom = love.graphics.newImage("images/bonomheu.png")
door = love.graphics.newImage("images/porte.png")
pp = love.graphics.newImage("images/pressurePlate.png")
mur = love.graphics.newImage("images/wall.png")
imgLi = {tree,KIOU,door,pp}
stateI = 1

----------------------------------------------

player = Player(32,4,4,bonhom,4,1,5,2)

---------------------------------------------- add scenes 
sceneListe = {}
sceneListe.menu = require('menu')
sceneListe.t1 = require('tuto1')
sceneListe.t2 = require('tuto2')
--CurrentMap = t1
----------------------------------------------

currentScene = sceneListe.menu-- a mettre menu / c fait owo


function love.update(dt)
  if not dialogueIsRunning then
    currentScene.update(dt)
  end
  dialogue.update(dt)
  if love.mouse.isDown(1) then
    mouseDown(love.mouse.getX(),love.mouse.getY())
  elseif love.mouse.isDown(2) and debugMode then
    currentScene.map.list[math.ceil(love.mouse.getX()/currentScene.map.size)][math.ceil(love.mouse.getY()/currentScene.map.size)] = 0 
    local iiii = 1
    
    while iiii <= #currentScene.map.underList do
      if currentScene.map.underList[iiii].x == math.ceil(love.mouse.getX()/currentScene.map.size) and currentScene.map.underList[iiii].y == math.ceil(love.mouse.getY()/currentScene.map.size) then 
        table.remove(currentScene.map.underList,iiii)-- si on enleve le iiii c'est magnifique 
      end
      iiii = iiii + 1
    end
    
  end
  

end 

function love.draw()
  currentScene.draw()
  dialogue.draw()
end 



function love.keypressed(key)
  
  if key == "r" then 
    currentScene.reset()
  end 

  
  if key == "1" then
    stateI = 1 
  elseif key == "2" then
    stateI = 2
  elseif key == "3" then
    stateI = 3
  elseif key == "4" then
    stateI = 4
  elseif key == "5" then
    stateI = 5 
  end 
  
  mapToChange = "map2" ----------------------------------------------
  if key == "p" and debugMode then
    print("player.x, player.y = "..player.x..","..player.y)
    print('player.but = {player.x,player.y}')
    for i = 1,#currentScene.map.list do
      for j = 1,#currentScene.map.list[i] do
        if currentScene.map.list[i][j] == 0 then
          
        elseif currentScene.map.list[i][j].img == tree then 
          print(mapToChange..".map.list["..i.."]["..j.."] = objStatique(tree)")
        elseif currentScene.map.list[i][j].img == KIOU then
          print(mapToChange..".map.list["..i.."]["..j..[[] = objStatique(KIOU,"movable")]])
        elseif currentScene.map.list[i][j].img == mur then
          print(mapToChange..".map.list["..i.."]["..j.."] = createWall()")
        end
      end 
    end 
    for i = 1, #currentScene.map.underList do
      if currentScene.map.underList[i].typeO == "pp" then
        print(mapToChange..".map.underList["..i.."] = pressurPlate("..currentScene.map.underList[i].x..","..currentScene.map.underList[i].y..")")
      end
    end 
  end
  
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
  
  if key == "a" then
    dialogue.addDialogue({"lol","lololoolollolololololololo","lollololloooloolololooloolololololollololololololololoololololololololololololololl"},player.x,player.y)
  end 
end

function mouseDown(x,y)
  if debugMode then
    if stateI == 1 then 
      currentScene.map.list[math.ceil(x/currentScene.map.size)][math.ceil(y/currentScene.map.size)] = objStatique(tree)
    elseif stateI == 2 then
      currentScene.map.list[math.ceil(x/currentScene.map.size)][math.ceil(y/currentScene.map.size)] = objStatique(KIOU,"movable")
    elseif stateI == 3 then 
      player.x, player.y = math.ceil(x/currentScene.map.size),math.ceil(y/currentScene.map.size)
      player.but = {player.x,player.y}
    elseif stateI == 4 then
      addPP(math.ceil(x/currentScene.map.size),math.ceil(y/currentScene.map.size))
    elseif stateI == 5 then 
       currentScene.map.list[math.ceil(x/currentScene.map.size)][math.ceil(y/currentScene.map.size)] = createWall()
    end
  end 
end 

function addPP(mx,my)
  for i = 1,#currentScene.map.underList do
    if currentScene.map.underList[i].x == mx and currentScene.map.underList[i].y == my then
      return 0
    end
  end
  currentScene.map.underList[#currentScene.map.underList+1] = pressurPlate(mx,my)
end