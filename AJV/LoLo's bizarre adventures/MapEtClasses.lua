


--function MapMob(nbligne,nbcolonne,size,backgroundimg)
--  love.window.setMode(nbligne*size,nbcolonne*size)
  

--  local myMap = {} 
--  myMap.size = size
--  myMap.nbligne = nbligne
--  myMap.nbcolonne = nbcolonne
--  myMap.listObj = {}
  
  
--  function myMap.update(dt)
--    for i = 1, #myMap.listObj do
--      myMap.listObj[i].update(dt)
--    end
--  end 
  
--  function myMap.draw()
--    for i = 1,#myMap.listObj do
--      myMap.listObj[i].draw(size,size)
--    end
--  end 
  
--  myMap.bcgdImg = backgroundimg or nil
  
  
  
--  function myMap.background()
--    love.graphics.draw(myMap.bcgdImg,0,0)
--  end 
  
--  function myMap.add(obj)
--    myMap.listObj[#myMap.listObj+1] = obj
--  end 
  
--  return myMap
--end






--function mob(x,y,img,updt,fps,nbe,etat,interaction,nbf)-- etats (son regard): bas haut droite gauche ... et puls si besoin 
--  local monObj = {}
--  monObj.x = x
--  monObj.y = y 
--  monObj.etat = etat or 1 
--  monObj.img = img
--  monObj.nbf = nbf or 1
--  monObj.nbe = nbe or 1
--  monObj.quadDimention = {}
--    monObj.quadDimention.x = 0
--    monObj.quadDimention.y = 0
--    monObj.quadDimention.w = monObj.img:getWidth()/monObj.nbf
--    monObj.quadDimention.h = monObj.img:getHeight()/monObj.nbe
--  monObj.cFrame = 1
--  monObj.tFrame = monObj.nbf
--  monObj.quad = love.graphics.newQuad(monObj.quadDimention.w*(monObj.cFrame-1),monObj.quadDimention.h*(monObj.etat-1),monObj.quadDimention.w,monObj.quadDimention.h,monObj.img:getWidth(),monObj.img:getHeight())
  
--  monObj.fps = fps or 10 
--  monObj.timer = 0
  
--  monObj.updt = updt(monObj) or function() end
  
  
--  function monObj.changeEtat(e,tf)
--    monObj.etat = e
--    monObj.cFrame = 1
--  end 
-- -- monObj.isInteract = false
--  monObj.interact = interaction or function() end
  
--  function monObj.anim(dt)
--    monObj.cFrame = changeUntilYouCant(monObj.cFrame,1,monObj.tFrame,1)
--    monObj.quad = love.graphics.newQuad(monObj.quadDimention.w*(monObj.cFrame-1),monObj.quadDimention.h*(monObj.etat-1),monObj.quadDimention.w,monObj.quadDimention.h,monObj.img:getWidth(),monObj.img:getHeight())
--  end 
  
--  function monObj.update(dt)
--    monObj.timer = monObj.timer + dt
--    if monObj.timer >= 1/monObj.fps then
--      monObj.updt(dt)
--      monObj.anim(dt)
--      monObj.timer = 0
--    end
--  end 
  
--  function monObj.draw(w,h)
--    love.graphics.draw(monObj.img,monObj.quad,monObj.x*w, monObj.y*h)
    
--  end
  
--  return monObj
--end 




--fin mob
--------------------------------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------------------------------
--debut map

function Map(nbligne,nbcolonne,size,backgroundimg)
  --love.window.setMode(nbligne*size,nbcolonne*size)
  
  
  local myMap = {} 
  myMap.size = size
  myMap.nbligne = nbligne
  myMap.nbcolonne = nbcolonne
  myMap.list = {}
  
  
  myMap.underList = {}
  --myMap.overlist  = {}
  
  function myMap.underListUpdate()
    for i = 1,#myMap.underList do
      if type(myMap.underList[i].update) ~= "nil" then
        myMap.underList[i].update(dt,myMap.list,myMap.overlist)
      end
    end
  end 
  function myMap.underListDraw()
    for i = 1,#myMap.underList do
      if type(myMap.underList[i].draw) ~= "nil" then
        myMap.underList[i].draw(myMap.size)
      end
    end
  end 
  
--  function myMap.overListUpdate()
--    for i = 1,#myMap.overlist do
--      if type(myMap.overlist[i].update) ~= "nil" then
--        myMap.overlist[i].update(dt,myMap.list,myMap.underList)
--      end
--    end
--  end
--  function myMap.overListDraw()
--    for i = 1,#myMap.overlist do
--      if type(myMap.overlist[i].draw) ~= "nil" then
--        myMap.overlist[i].draw(myMap.size)
--      end
--    end
--  end
  
  
  for i = 1, nbligne do
    myMap.list[#myMap.list+1] = {}
    for j = 1, nbcolonne do
      myMap.list[i][j] = 0
    end
  end

  
  function myMap.update(dt)
    for i = 1, myMap.nbligne do
      for j = 1, myMap.nbcolonne do
        if myMap.list[i][j] ~= 0 and type(myMap.list[i][j].update) ~= "nil" then
          myMap.list[i][j].update(dt,i,j,myMap.list,myMap.underList--[[,myMap.overList]])
        end 
      end
    end
    
    myMap.underListUpdate()
    --myMap.overListUpdate()
  end 
  
  myMap.bcgdImg = backgroundimg or nil
  
  function myMap.background()
    if type(myMap.bcgdImg) ~= "nil" then
      love.graphics.draw(myMap.bcgdImg,0,0)
    end
  end 
  
  function myMap.draw()
    myMap.background()
    myMap.underListDraw()
    for i = 1, myMap.nbligne do
      for j = 1, myMap.nbcolonne do
        if myMap.list[i][j] ~= 0 then
          myMap.list[i][j].draw((i-1),(j-1),myMap.size)
        end 
        if debugMode then 
          love.graphics.rectangle("line",(i-1)*myMap.size,(j-1)*myMap.size,myMap.size,myMap.size)
          --love.graphics.print(i.."\n"..j,(i-1)*myMap.size,(j-1)*myMap.size)
        end 
      end
    end
   -- myMap.overListDraw()
  end 
  
  
  return myMap
end 





function objStatique(img,Type)
  local monTruc = {}
  monTruc.img = img
  monTruc.typeO = Type 
  
  function monTruc.draw(x,y,s)
    love.graphics.draw(monTruc.img,x*s,y*s,0,0.32,0.32)
  end
  
  return monTruc
end




function createPorte(destination,mapSpawn,Type)
  local maPorte = {}
   
  maPorte.typeO = Type
  
  function maPorte.update(dt,x,y)
    if ( math.floor(player.x) == x  or math.ceil(player.x) == x ) and ( player.y == y  or math.ceil(player.y) == y ) then
      player.x, player.y = mapSpawn[1],mapSpawn[2]
    player.but = {player.x,player.y}
    currentScene = destination
    currentScene.reset()
    end 
  end
  
  function maPorte.draw(x,y,s)
    love.graphics.draw(door,x*s,y*s,0,0.32,0.32)
  end 
  
  
  return maPorte
end 


function pressurPlate(x,y)
  local mpp = {}
  mpp.x = x
  mpp.y = y 
  mpp.quad = love.graphics.newQuad(0,0,pp:getWidth(),pp:getHeight()/2,pp:getWidth(),pp:getHeight())
  mpp.state = 1 -- 1 ou 2 
  mpp.typeO = "pp"
  
  function mpp.update(dt,list,overList)
    mpp.state = 1
    
    if player.x == mpp.x and player.y == mpp.y then
      mpp.state = 2
    end 
    
    
    if list[mpp.x][mpp.y] ~= 0 then 
      mpp.state = 2
    end
    
--    for i = 1,#overList do
--      if overList[i].x == mpp.x and overList[i].y == mpp.y then
--      mpp.state = 2
--      end 
--    end
    mpp.quad = love.graphics.newQuad(0,(pp:getHeight()/2)*(mpp.state-1),pp:getWidth(),pp:getHeight()/2,pp:getWidth(),pp:getHeight())
  end 
  
  function mpp.draw(s)
    love.graphics.draw(pp,mpp.quad,(mpp.x-1)*s,(mpp.y-1)*s,0,0.32,0.32)
  end 
  
  return mpp
end

function createWall()
  local myWall = {}
  
  myWall.quad = love.graphics.newQuad(0,0,mur:getWidth(),mur:getHeight()/2,mur:getWidth(),mur:getHeight())
  myWall.state = 1 
  myWall.typeO = "solid"
  myWall.img = mur
  
  function myWall.update(dt,x,y,liste,underL--[[,overL]])
    myWall.typeO = "fantom"
    myWall.state = 2 
    for i = 1,#underL do
      if underL[i].typeO == "pp" and underL[i].state == 1 then 
        myWall.state = 1
        myWall.typeO = "solid"
      end 
    end
    myWall.quad = love.graphics.newQuad(0,(mur:getHeight()/2)*(myWall.state-1),mur:getWidth(),mur:getHeight()/2,mur:getWidth(),mur:getHeight())
  end 
  
  function myWall.draw(x,y,s)
    love.graphics.draw(mur,myWall.quad,x*s,y*s,0,0.32,0.32)
  end 
  return myWall
end



--function createFolower(img,x,y,fps)
--  myMob.x, myMob.y = x,y 
--  myMob.but = {x,y}
  
  
--end 



function Pancarte(listeTxt)
  montxt = {}
  montxt.typeO = "solid"
  montxt.listTxt = listeTxt
  montxt.currentTxt = ""
  montxt.i = 1
  --quadDuScreen = love.graphics.newQuad((player.x-1)*screen:getWidth()/33,(player.y-1)*screen:getHeight()/23,32,32,screen:getWidth(),screen:getHeight())
  
  function montxt.update(dt,x,y)
    if ((player.x  == x and player.y == y-1 and player.etat == 1) or 
        (player.x  == x and player.y == y+1 and player.etat == 2) or 
        (player.x  == x-1 and player.y == y and player.etat == 3) or 
        (player.x  == x+1 and player.y == y and player.etat == 4)) and love.keyboard.isDown("e") then 
        
      dialogue.addDialogue(montxt.listTxt,x,y)
    end
  end
  
--  function montxt.draw(mw,mh,ms)
--    love
--  end 
end

function Dialogue(eee)
  monDia = {}
  monDia.ldt = {}
  monDia.currentTxt = ""
  --monDia.i = 1
  monDia.j = 1
  monDia.timer = 0
  
  monDia.objx = 0
  monDia.objy = 0
  monDia.objImg = nil
  monDia.objquad = nil
  
  monDia.screenIsTaken = 0
  
  function monDia.update(dt)
    monDia.timer = monDia.timer + dt
    if #monDia.ldt ~= 0 then
      dialogueIsRunning = true
      if monDia.currentTxt ~= monDia.ldt[1] then
        monDia.currentTxt = string.sub(monDia.ldt[1],1,monDia.j)
        monDia.j = monDia.j + 1
      end
      if monDia.timer > 0.2 then
        if love.keyboard.isDown("space") then
          monDia.timer = 0
          if monDia.currentTxt ~= monDia.ldt[1] then
            monDia.currentTxt = monDia.ldt[1]
          else
            table.remove(monDia.ldt,1)
            monDia.currentTxt = ""
            monDia.j = 1 
          end 
        end 
      end
    else 
      dialogueIsRunning = false
    end
  end
  
  function monDia.draw()
    if #monDia.ldt ~= 0 and monDia.screenIsTaken >= 1 then
      monDia.objImg = love.graphics.newImage("newScreenshot.png")
      love.graphics.rectangle("fill",200,love.graphics.getHeight()-200,love.graphics.getWidth()-200,200)
      love.graphics.draw(monDia.objImg,monDia.objquad,0,love.graphics.getHeight()-200,0,200/32,200/32)
      
      love.graphics.setColor(1,0,0)
      monDia.txtWidth, monDia.txtLignes = font:getWrap(monDia.currentTxt,love.graphics.getWidth()-200)
      monDia.txtHeight = (#monDia.txtLignes ) * (font:getHeight() + font:getLineHeight())  
      
      love.graphics.printf(monDia.currentTxt, 200,love.graphics.getHeight()-100-monDia.txtHeight/2,love.graphics.getWidth()-200,"left")
      love.graphics.setColor(1,1,1) 
    end
    
    monDia.screenIsTaken = monDia.screenIsTaken + 1
  end 
  
  function monDia.addDialogue(ldt,x,y)
    monDia.currentTxt = ""
    dialogueIsRunning = true
    monDia.ldt = ldt
    love.graphics.captureScreenshot("newScreenshot.png")
    monDia.screenIsTaken = 0
    monDia.objImg = love.graphics.newImage("newScreenshot.png")
    monDia.objquad = love.graphics.newQuad((x-1)*32,(y-1)*32,32,32,monDia.objImg:getWidth(),monDia.objImg:getHeight())
  end
  
  

  return monDia
end 

--fin map
--------------------------------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------------------------------
--debut perso 


function Player(mapSize,x,y,img,nbe,etat,fps,nbf)-- etats (son regard): bas haut droite gauche (parce que ca marche birn et ca fait presque ("n","z","d","q"...)
    local monPlayer = {}
    monPlayer.x = x
    monPlayer.y = y 
    monPlayer.vitesse = {0,"x"}
    monPlayer.but = {monPlayer.x,monPlayer.y}
    monPlayer.mapx = math.floor(monPlayer.x/mapSize)
    monPlayer.mapy = math.floor(monPlayer.y/mapSize)
    
    monPlayer.etat = etat or 1 
    monPlayer.img = img
    monPlayer.nbf = nbf or 1
    monPlayer.nbe = nbe or 1
    
    monPlayer.action = 0 -- 1 si rien, 2 si en marche
    
    monPlayer.quadDimention = {}
      monPlayer.quadDimention.x = 0
      monPlayer.quadDimention.y = 0
      monPlayer.quadDimention.w = monPlayer.img:getWidth()/monPlayer.nbf
      monPlayer.quadDimention.h = monPlayer.img:getHeight()/(monPlayer.nbe*2)
    monPlayer.cFrame = 1
    monPlayer.tFrame = monPlayer.nbf
    monPlayer.quad = love.graphics.newQuad(monPlayer.quadDimention.w*(monPlayer.cFrame-1),monPlayer.quadDimention.h*((monPlayer.etat-1)+monPlayer.nbe*monPlayer.action),monPlayer.quadDimention.w,monPlayer.quadDimention.h,monPlayer.img:getWidth(),monPlayer.img:getHeight())
    
    monPlayer.fps = fps or 10 
    monPlayer.timer = 0
        
    
    function monPlayer.anim(dt)
      if monPlayer.x ~= monPlayer.but[1] or monPlayer.y ~= monPlayer.but[2] then 
        monPlayer[monPlayer.vitesse[2]] = monPlayer[monPlayer.vitesse[2]] + monPlayer.vitesse[1]
      end
      monPlayer.quad = love.graphics.newQuad(monPlayer.quadDimention.w*(monPlayer.cFrame-1),monPlayer.quadDimention.h*((monPlayer.etat-1)+monPlayer.nbe*monPlayer.action),monPlayer.quadDimention.w,monPlayer.quadDimention.h,monPlayer.img:getWidth(),monPlayer.img:getHeight())
      
      if monPlayer.cFrame >= monPlayer.tFrame then 
        monPlayer.action = 0 
      end 
      
      monPlayer.cFrame = changeUntilYouCant(monPlayer.cFrame,1,monPlayer.tFrame,1)
    end 
    
    function monPlayer.update(dt,map)
      monPlayer.timer = monPlayer.timer + dt
      monPlayer.move(map)
      if monPlayer.timer >= 1/monPlayer.fps then
        
        monPlayer.anim(dt)
        monPlayer.timer = 0
--        print(monPlayer.x,monPlayer.y)
--        print(math.ceil(monPlayer.x-1),math.floor(monPlayer.y))
      end
    end 
    
    function monPlayer.draw()
      love.graphics.draw(monPlayer.img,monPlayer.quad,(monPlayer.x-1)*mapSize, (monPlayer.y-1)*mapSize,0,0.32,0.32)
    end


    function monPlayer.move(map,dt)
     
      if monPlayer.x == monPlayer.but[1] and monPlayer.y == monPlayer.but[2] then 
        
        if love.keyboard.isDown('s') then
          monPlayer.etat = 1 
          if type(map.list[monPlayer.x][monPlayer.y+1]) ~= "nil"  then 
            if map.list[monPlayer.x][monPlayer.y+1] == 0 or map.list[monPlayer.x][monPlayer.y+1].typeO == "fantom" then
              monPlayer.vitesse = {0.5,"y"}
              monPlayer.but = {monPlayer.x,monPlayer.y+1}
              monPlayer.action = 1
              monPlayer.cFrame = 1
              monPlayer.timer = 1000000000

            elseif map.list[monPlayer.x][monPlayer.y+1].typeO == "movable" and type(map.list[monPlayer.x][monPlayer.y+2]) ~= "nil" and map.list[monPlayer.x][monPlayer.y+2] == 0 then
              map.list[monPlayer.x][monPlayer.y+2] = map.list[monPlayer.x][monPlayer.y+1]
              map.list[monPlayer.x][monPlayer.y+1] = 0
            end 
          end
        
        
        elseif love.keyboard.isDown('z') then
          monPlayer.etat = 2 
          if type(map.list[monPlayer.x][monPlayer.y-1]) ~= "nil"  then 
            if map.list[monPlayer.x][monPlayer.y-1] == 0 or map.list[monPlayer.x][monPlayer.y-1].typeO == "fantom" then
              monPlayer.vitesse = {-0.5,"y"}
              monPlayer.but = {monPlayer.x,monPlayer.y-1}
              monPlayer.action = 1
              monPlayer.cFrame = 1
              monPlayer.timer = 1000000000

            elseif map.list[monPlayer.x][monPlayer.y-1].typeO == "movable" and type(map.list[monPlayer.x][monPlayer.y-2]) ~= "nil" and map.list[monPlayer.x][monPlayer.y-2] == 0 then
              map.list[monPlayer.x][monPlayer.y-2] = map.list[monPlayer.x][monPlayer.y-1]
              map.list[monPlayer.x][monPlayer.y-1] = 0
            end 
          end
        
        elseif love.keyboard.isDown('d') then
          monPlayer.etat = 3 
          if type(map.list[monPlayer.x+1]) ~= "nil"  then 
            if map.list[monPlayer.x+1][monPlayer.y] == 0 or map.list[monPlayer.x+1][monPlayer.y].typeO == "fantom" then
              monPlayer.vitesse = {0.5,"x"}
              monPlayer.but = {monPlayer.x+1,monPlayer.y}
              monPlayer.action = 1
              monPlayer.cFrame = 1
              monPlayer.timer = 1000000000

            elseif map.list[monPlayer.x+1][monPlayer.y].typeO == "movable" and type(map.list[monPlayer.x+2]) ~= "nil" and map.list[monPlayer.x+2][monPlayer.y] == 0 then
              map.list[monPlayer.x+2][monPlayer.y] = map.list[monPlayer.x+1][monPlayer.y]
              map.list[monPlayer.x+1][monPlayer.y] = 0
            end 
          end
        
        elseif love.keyboard.isDown('q') then
          monPlayer.etat = 4
          if type(map.list[monPlayer.x-1]) ~= "nil"  then 
            if map.list[monPlayer.x-1][monPlayer.y] == 0 or map.list[monPlayer.x-1][monPlayer.y].typeO == "fantom" then
              monPlayer.vitesse = {-0.5,"x"}
              monPlayer.but = {monPlayer.x-1,monPlayer.y}
              monPlayer.action = 1
              monPlayer.cFrame = 1
              monPlayer.timer = 1000000000

            elseif map.list[monPlayer.x-1][monPlayer.y].typeO == "movable" and type(map.list[monPlayer.x-2]) ~= "nil" and map.list[monPlayer.x-2][monPlayer.y] == 0 then
              map.list[monPlayer.x-2][monPlayer.y] = map.list[monPlayer.x-1][monPlayer.y]
              map.list[monPlayer.x-1][monPlayer.y] = 0
            end 
          end
        end
      end 
      
    end 
    
    return monPlayer
  end 
  
--fin perso
--------------------------------------------------------------------------------------------------------------------------------------------
-- debut fonction utiles et nessecaires au bon fonctionement du programme 

function changeUntilYouCant(v,o,l,i)--respectivement Valeur, Origine, Limite et Increment : tous des valeurs numeriques 
  -- sert a augementer une valeur ("v") en additionant ("i") jusqu'a un certain points ("l") et lorsqu'il est atteint ou depassé remet la valeur a son pts de depart ("o")
  if i > 0 then
    if v >= l then 
      v = o 
    else
      v = v + i 
    end
  elseif i < 0 then
    if v <= l then 
      v = o 
    else
      v = v + i 
    end
  end
    
  return v
end 