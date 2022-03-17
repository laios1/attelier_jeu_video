io.stdout:setvbuf('no')


function love.load()
  
  winW = 450
  winH = 600
  love.window.setMode(winW,winH)
  
  background = love.graphics.newImage("image/background.png")
  flappyImg = love.graphics.newImage("image/flappy.png")
  tuyauHaut = love.graphics.newImage("image/tuyauhaut.png")
  tuyauBas = love.graphics.newImage("image/tuyauBas.png")
  solimg = love.graphics.newImage("image/sol.jpg")

  scoreFont = love.graphics.newFont(50)
  love.graphics.setFont(scoreFont)
  
  gravity = 1500
  
  require("sol")
  require("flappy")
  require("tuyaux")

  gameState = "intro"
  
  timer = 0 
  score = 0 
  testToPass = true
end 

function initGame()
  gameState = "play"
  flappy.y = winH*0.4
  flappy.vy = 0 
  flappy.ay = 0
  flappy.Fext = 0 
  flappy.rotation = 0
  timer = 0 
  score = 0 
  testToPass = true
  lstTuyaux = {}
  sol.vx = 150
  tvx = 150
  end 

function updateScore()
  if #lstTuyaux > 0 and lstTuyaux[1].x < -lstTuyaux[1].w then
    table.remove(lstTuyaux,1)
    testToPass = true
  end 
  if #lstTuyaux > 0 and lstTuyaux[1].x + lstTuyaux[1].w < flappy.x and testToPass then
    score = score + 1 
    testToPass = false
  end 
end 

function love.update(dt)
  if gameState == "intro" then 
    sol.update(dt)
  end
  
  if gameState == "GameOver" then
    if not flappy.collideSol(sol) then
      flappy.update(dt)
    else
      timer = timer  + 1
      if timer > 500 then 
        gameState = "GiveUp"
      end
    end 
  end 
  
  if gameState == "GiveUp" then
    timer = timer  + 1
    sol.vx = 1500
    tvx = 1500
    if flappy.collideSol(sol) then
      flappy.applyForce(-gravity) 
      flappy.vy = 0
    end 
    flappy.update(dt)
    flappy.rotation = flappy.rotation + 1 
        sol.update(dt)
        if math.floor(timer) % 10 == 0  then
          addTuyau()
        end 
        for k = 1, #lstTuyaux do 
          lstTuyaux[k].move(dt)
        end 
        updateScore()
  end 
  
  if gameState == "play" then 
    flappy.update(dt)
    sol.update(dt)
    updateScore()
    if flappy.collideSol(sol) then
      gameState = "GameOver"
      timer = 0 
    end 
    for i = 1, #lstTuyaux do 
      if flappy.collideT(lstTuyaux[i]) then 
        gameState = "GameOver"
        timer = 0 
      end 
    end 
    timer = timer + dt
    
    if timer > 3 then
      timer = 0 
      addTuyau()
    end 
    
    for k = 1, #lstTuyaux do 
      lstTuyaux[k].move(dt)
    end 
  end 
  
  
end 

function love.draw()
  love.graphics.draw(background,0,0)
  sol.draw()
  flappy.draw()
  
  for k = 1, #lstTuyaux do 
    lstTuyaux[k].draw()
  end 
  love.graphics.print(score,0,0)
end 

function love.keypressed(key)
  if gameState == "intro" then 
    if key == "space" then
      gameState = "play"
      --flappy.applyForce(flappy.bounce/2)
    end 
  end 
  
  if gameState == "GiveUp" then 
    if key == "space" then
      flappy.vy = 0 
      flappy.applyForce(flappy.bounce*2)
    end 
  end
  
  if gameState == "play" then 
    if key == "space" then
      flappy.vy = 0 
      flappy.applyForce(flappy.bounce)
    end 
  end
  
  if gameState == "GameOver" then 
    if key == "space" then
      initGame()
    end 
  end
end 