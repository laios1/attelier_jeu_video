


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
          myMap.list[i][j].update(dt,i,j)
        end 
      end
    end
  end 
  
  myMap.bcgdImg = backgroundimg or nil
  
  function myMap.background()
    if type(myMap.bcgdImg) ~= "nil" then
      love.graphics.draw(myMap.bcgdImg,0,0)
    end
  end 
  
  function myMap.draw()
    myMap.background()
    for i = 1, myMap.nbligne do
      for j = 1, myMap.nbcolonne do
        if myMap.list[i][j] ~= 0 then
          myMap.list[i][j].draw((i-1),(j-1),myMap.size)
        end 
        if debugMode then 
          love.graphics.rectangle("line",(i-1)*myMap.size,(j-1)*myMap.size,myMap.size,myMap.size)
          love.graphics.print(i.."\n"..j,(i-1)*myMap.size,(j-1)*myMap.size)
        end 
      end
    end
  end 
  
  
  return myMap
end 



function objStatique(img,updt,Type)
  local monTruc = {}
  monTruc.img = img
  monTruc.typeO = Type or "solid"
  
  
  if type(updt) ~= "nil" then
    monTruc.update = updt --doit prendre un dt, un x et un y  
  end 
  
  function monTruc.draw(x,y,s)
    love.graphics.draw(monTruc.img,x*s,y*s)
  end
  
  return monTruc
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
      if monPlayer.timer >= 1/monPlayer.fps then
        monPlayer.move(map)
        monPlayer.anim(dt)
        monPlayer.timer = 0
--        print(monPlayer.x,monPlayer.y)
--        print(math.ceil(monPlayer.x-1),math.floor(monPlayer.y))
      end
    end 
    
    function monPlayer.draw()
      love.graphics.draw(monPlayer.img,monPlayer.quad,(monPlayer.x-1)*mapSize, (monPlayer.y-1)*mapSize)
    end

--    function monPlayer.move(map)
--      if love.keyboard.isDown("s") then 
--        monPlayer.etat = 1 
--        if type(map.list[math.floor(monPlayer.x)][math.floor(monPlayer.y+1)]) ~= "nil"  then 
--          if map.list[math.floor(monPlayer.x)][math.floor(monPlayer.y+1)] == 0 then
--            monPlayer.y = monPlayer.y + 0.5 
--            monPlayer.action = 1
--          elseif map.list[math.floor(monPlayer.x)][math.floor(monPlayer.y+1)].typeO == "door" then 
--            monPlayer.y = monPlayer.y + 0.5 
--            monPlayer.action = 1
--          elseif map.list[math.floor(monPlayer.x)][math.floor(monPlayer.y+1)].typeO == "movable" and type(map.list[math.floor(monPlayer.x)][math.floor(monPlayer.y+2)]) ~= "nil" and map.list[math.floor(monPlayer.x)][math.floor(monPlayer.y+2)] == 0 then
--            map.list[math.floor(monPlayer.x)][math.floor(monPlayer.y+2)] = map.list[math.floor(monPlayer.x)][math.floor(monPlayer.y+1)]
--            map.list[math.floor(monPlayer.x)][math.floor(monPlayer.y+1)] = 0
--          end 
--        end
        
--      elseif love.keyboard.isDown("z") then
--        monPlayer.etat = 2
----        print(map.list[math.floor(monPlayer.x)][math.floor(monPlayer.y-1)])
--        if type(map.list[math.floor(monPlayer.x)][math.ceil(monPlayer.y-1)]) ~= "nil" then 
--          if map.list[math.floor(monPlayer.x)][math.ceil(monPlayer.y-1)] == 0 then 
--            monPlayer.y = monPlayer.y - 0.5 
--            monPlayer.action = 1
--          elseif map.list[math.floor(monPlayer.x)][math.ceil(monPlayer.y-1)].typeO == "door" then 
--            monPlayer.y = monPlayer.y - 0.5 
--            monPlayer.action = 1
--          elseif map.list[math.floor(monPlayer.x)][math.ceil(monPlayer.y-1)].typeO == "movable" and type(map.list[math.floor(monPlayer.x)][math.ceil(monPlayer.y-2)]) ~= "nil" and map.list[math.floor(monPlayer.x)][math.floor(monPlayer.y-2)] == 0 then
--            map.list[math.floor(monPlayer.x)][math.ceil(monPlayer.y-2)] = map.list[math.floor(monPlayer.x)][math.ceil(monPlayer.y-1)]
--            map.list[math.floor(monPlayer.x)][math.ceil(monPlayer.y-1)] = 0
--          end 
--        end 
--      elseif love.keyboard.isDown("d") then
--        monPlayer.etat = 3
--        if type(map.list[math.floor(monPlayer.x+1)]) ~= "nil" then 
--          if map.list[math.floor(monPlayer.x+1)][math.floor(monPlayer.y)] == 0 then 
--            monPlayer.x = monPlayer.x + 0.5 
--            monPlayer.action = 1
--          elseif map.list[math.floor(monPlayer.x+1)][math.floor(monPlayer.y)].typeO == "door" then 
--            monPlayer.x = monPlayer.x + 0.5 
--            monPlayer.action = 1
--          elseif map.list[math.floor(monPlayer.x+1)][math.floor(monPlayer.y)].typeO == "movable" and type(map.list[math.floor(monPlayer.x+2)]) ~= "nil" and map.list[math.floor(monPlayer.x+2)][math.floor(monPlayer.y)] == 0 then
--            map.list[math.floor(monPlayer.x+2)][math.floor(monPlayer.y)] = map.list[math.floor(monPlayer.x+1)][math.floor(monPlayer.y)]
--            map.list[math.floor(monPlayer.x+1)][math.floor(monPlayer.y)] = 0
--          end 
--        end 
--      elseif love.keyboard.isDown("q") then
--        monPlayer.etat = 4
--        if type(map.list[math.ceil(monPlayer.x-1)]) ~= "nil" then 
--          if map.list[math.ceil(monPlayer.x-1)][math.floor(monPlayer.y)] == 0 then 
--            monPlayer.x = monPlayer.x - 0.5 
--            monPlayer.action = 1
--          elseif map.list[math.ceil(monPlayer.x-1)][math.floor(monPlayer.y)].typeO == "door" then 
--            monPlayer.x = monPlayer.x - 0.5 
--            monPlayer.action = 1
--          elseif map.list[math.ceil(monPlayer.x-1)][math.floor(monPlayer.y)].typeO == "movable" and type(map.list[math.ceil(monPlayer.x-2)]) ~= "nil" and map.list[math.floor(monPlayer.x-2)][math.floor(monPlayer.y)] == 0 then
--            map.list[math.ceil(monPlayer.x-2)][math.floor(monPlayer.y)] = map.list[math.ceil(monPlayer.x-1)][math.floor(monPlayer.y)]
--            map.list[math.ceil(monPlayer.x-1)][math.floor(monPlayer.y)] = 0
--          end 
--        end 
--      end 
--    end 
    function monPlayer.move(map,dt)
     
      if monPlayer.x == monPlayer.but[1] and monPlayer.y == monPlayer.but[2] then 
        
        if love.keyboard.isDown('s') then
          monPlayer.etat = 1 
          if type(map.list[monPlayer.x][monPlayer.y+1]) ~= "nil"  then 
            if map.list[monPlayer.x][monPlayer.y+1] == 0 then
              monPlayer.vitesse = {0.5,"y"}
              monPlayer.but = {monPlayer.x,monPlayer.y+1}
              monPlayer.action = 1
              monPlayer.cFrame = 1
            elseif map.list[monPlayer.x][monPlayer.y+1].typeO == "door" then 
              monPlayer.vitesse = {0.5,"y"}
              monPlayer.but = {monPlayer.x,monPlayer.y+1}
              monPlayer.action = 1
              monPlayer.cFrame = 1
            elseif map.list[monPlayer.x][monPlayer.y+1].typeO == "movable" and type(map.list[monPlayer.x][monPlayer.y+2]) ~= "nil" and map.list[monPlayer.x][monPlayer.y+2] == 0 then
              map.list[monPlayer.x][monPlayer.y+2] = map.list[monPlayer.x][monPlayer.y+1]
              map.list[monPlayer.x][monPlayer.y+1] = 0
            end 
          end
        end
        
        if love.keyboard.isDown('z') then
          monPlayer.etat = 2 
          if type(map.list[monPlayer.x][monPlayer.y-1]) ~= "nil"  then 
            if map.list[monPlayer.x][monPlayer.y-1] == 0 then
              monPlayer.vitesse = {-0.5,"y"}
              monPlayer.but = {monPlayer.x,monPlayer.y-1}
              monPlayer.action = 1
              monPlayer.cFrame = 1
            elseif map.list[monPlayer.x][monPlayer.y-1].typeO == "door" then 
              monPlayer.vitesse = {-0.5,"y"}
              monPlayer.but = {monPlayer.x,monPlayer.y-1}
              monPlayer.action = 1
              monPlayer.cFrame = 1
            elseif map.list[monPlayer.x][monPlayer.y-1].typeO == "movable" and type(map.list[monPlayer.x][monPlayer.y-2]) ~= "nil" and map.list[monPlayer.x][monPlayer.y-2] == 0 then
              map.list[monPlayer.x][monPlayer.y-2] = map.list[monPlayer.x][monPlayer.y-1]
              map.list[monPlayer.x][monPlayer.y-1] = 0
            end 
          end
        end
        
        if love.keyboard.isDown('d') then
          monPlayer.etat = 3 
          if type(map.list[monPlayer.x+1]) ~= "nil"  then 
            if map.list[monPlayer.x+1][monPlayer.y] == 0 then
              monPlayer.vitesse = {0.5,"x"}
              monPlayer.but = {monPlayer.x+1,monPlayer.y}
              monPlayer.action = 1
              monPlayer.cFrame = 1
            elseif map.list[monPlayer.x+1][monPlayer.y].typeO == "door" then 
              monPlayer.vitesse = {0.5,"x"}
              monPlayer.but = {monPlayer.x+1,monPlayer.y}
              monPlayer.action = 1
              monPlayer.cFrame = 1
            elseif map.list[monPlayer.x+1][monPlayer.y].typeO == "movable" and type(map.list[monPlayer.x+2]) ~= "nil" and map.list[monPlayer.x+2][monPlayer.y] == 0 then
              map.list[monPlayer.x+2][monPlayer.y] = map.list[monPlayer.x+1][monPlayer.y]
              map.list[monPlayer.x+1][monPlayer.y] = 0
            end 
          end
        end
        
        if love.keyboard.isDown('q') then
          monPlayer.etat = 4
          if type(map.list[monPlayer.x-1]) ~= "nil"  then 
            if map.list[monPlayer.x-1][monPlayer.y] == 0 then
              monPlayer.vitesse = {-0.5,"x"}
              monPlayer.but = {monPlayer.x-1,monPlayer.y}
              monPlayer.action = 1
              monPlayer.cFrame = 1
            elseif map.list[monPlayer.x-1][monPlayer.y].typeO == "door" then 
              monPlayer.vitesse = {-0.5,"x"}
              monPlayer.but = {monPlayer.x-1,monPlayer.y}
              monPlayer.action = 1
              monPlayer.cFrame = 1
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
  -- sert a augementer une valeur ("v") en additionant ("i") jusqu'a un certain points ("l") et lorse qu'il est atteint remet la valeur a son pts de depart ("o")
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