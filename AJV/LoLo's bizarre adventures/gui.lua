-- biblioteque pour faire des bouton carré ou ront ( c'est bien penser et ca marche mais pas du tout intuitif a uttiliser sans connaitre tous le code au prealable )



function btRond(action,x,y,rayon,bttype,txt,backgroundColor,txtColor,img)
  -- prend : une action qui est une fonction qui s'active lorce que notre bouton est activée (optionel)(par defaut print "non" si il est activé)
  -- prend : un x,y et un rayon 
  -- prend : un type de bouton ("push" pour un bouton ou il faut rester appuier pour le faire fonctioner et "switch" pour un interupteur (soit allumé soit etein)) (par defaut "push")
  -- prend : un txt (str) (optionel)
  
--[[ prend : un background color qui est soi une table comprenant 3 valeurs entre 0 et 1 (ex : {1,0,0} pour du rouge) 

  ou une table comprenant 2 ou 3 tables elles memes comprenant 3 valeurs entre 0 et 1 (ex : {{1,0,0},{0,1,0},{0,0,1} pour {rouge,vert,bleu}) qui serout uttiliser respectivement comme : couleur de base, couleur de survole et couleur d'action, quand il y a 2 couleur (ex : {{1,0,0},{0,0,1} pour {rouge,bleu}) ce sera juste couleur de base et couleur d'action
  
  ou des une table de 2 ou 3 quad marchant comme le cas precedent ( 3 = image de base, image de survole et image d'action et 2 = image de base et image d'action 
  
  ps : un quad necessite une image]]
  
  -- prend : une couleur de texte ({1,1,1} pour le blanc) 
  
  --[[ prend : une image ( le fichier de l'image complete si quad ). mais si on ne veut qu'une image ne marche que sur un background blanc ne changant pas 
      
      ps = ce n'est pas la taille de l'image qui est appliquer mais la taille du bouton donc si la taille du bouton n'est pas proportionelle a celle de l'image elle va s'etirer ou s'ecraser ]] 
  monBt = {}
  monBt.action = action or function() print('non') end
  monBt.state = false
  monBt.rayon = rayon
  monBt.x = x
  monBt.y = y 
  monBt.txt = txt or ""
  monBt.type = bttype or "push"
  if type(backgroundColor) == "nil" or type(backgroundColor[1]) == "number" then
    monBt.bg = backgroundColor or {1,1,1}
    if monBt.bg[1] == 1 and monBt.bg[2] == 1 and monBt.bg[3] == 1 then
      monBt.img = img
      monBt.imgW = monBt.img:getWidth()
      monBt.imgH = monBt.img:getHeight()
    end 
  else
    if type(backgroundColor[1]) == "table" then 
      monBt.bg = backgroundColor
      monBt.mode = 1
    else
      monBt.mode = 1 
      monBt.bg = backgroundColor
      monBt.img = img 
      monBt.frame = #backgroundColor
      monBt.w = monBt.img:getWidth()
      monBt.h = monBt.img:getHeight()/monBt.frame
    end
  end
  monBt.timer = 0
  monBt.txtcolor = txtColor or {0,0,0} --if monBt.bg[1] + monBt.bg[2] + monBt.bg[3] >= 1.5 then {0,0,0} else {1,1,1} end
  monBt.mouseOver = function()
    if ((monBt.x - love.mouse.getX())^2 + (monBt.y - love.mouse.getY())^2)^0.5 <= rayon then
      return true
    else 
      return false 
    end
  end 
  if type(monBt.bg[1]) == "number" then 
    monBt.update = function(dt)
      
      if monBt.type == "push" then
        monBt.state = false
      end
      monBt.timer = monBt.timer + dt
      if monBt.mouseOver() then
          local a = {}
          if type(backgroundColor) == "table" then
            for i = 1,#backgroundColor do
              a[i] = backgroundColor[i] 
            end
          else
            a = {1,1,1}
          end 
          if monBt.type == "push" then
            a[4] = 0.9
          end
          if love.mouse.isDown(1) then
            if monBt.type == "push" then
              a[4] = 0.6
              monBt.state = true
            elseif  monBt.timer > 0.2 then
              monBt.timer = 0
              if monBt.state then
              monBt.state = false
              a[4] = 0.6
              else 
              monBt.state = true
              a[4] = 1
              end
            end
            
          end
          if monBt.type ~= "push" then
            if monBt.state then
            a[4] = 0.6
            else 
            a[4] = 1
            end
          end
          monBt.bg = a
      else
        monBt.bg = backgroundColor or {1,1,1}
        
        if monBt.type ~= "push" then
            if monBt.state then
            monBt.bg[4] = 0.6
            else 
            monBt.bg[4] = 1
            end
          end
      end
    end
    monBt.draw = function()
      if monBt.state then
        monBt.action()
      end
      love.graphics.setColor(monBt.bg)
      love.graphics.circle("fill",monBt.x,monBt.y,monBt.rayon)
      if type(monBt.img) ~= "nil" then 
        love.graphics.draw(monBt.img,monBt.x,monBt.y,0,monBt.rayon/monBt.imgW,monBt.rayon/monBt.imgH)
      end 
      love.graphics.setColor(monBt.txtcolor)
      love.graphics.print(monBt.txt,monBt.x,monBt.y,0,1,1,10*#monBt.txt/2,15/2)
      love.graphics.setColor(1,1,1)
    end
    
  else 
    monBt.update = function(dt)
      monBt.timer = monBt.timer + dt
      if monBt.type == "push" then
        monBt.state = false
      end
      if monBt.mouseOver() then
        if #backgroundColor == 3 then 
          monBt.mode = 2
          if love.mouse.isDown(1) then
            monBt.mode = 3
            monBt.state = true
          end
        else 
          if monBt.type == "push" then
            monBt.mode = 1
          end
          if love.mouse.isDown(1) then
            if monBt.type == "push" then
              monBt.mode = 2
              monBt.state = true
            elseif  monBt.timer > 0.2 then
                monBt.timer = 0
              if monBt.state then
                monBt.state = false
                monBt.mode = 1
              else 
                monBt.state = true
                monBt.mode = 2
              end
            end
          end
        end 
        love.graphics.setColor(1,1,1,0.7)
      else
        if monBt.type == "push" then
          monBt.mode = 1 
        end
        love.graphics.setColor(1,1,1,1)
      end
--      monBt.bg = bgcl
    end
    monBt.draw = function()
      if monBt.state then
        monBt.action()
      end
      if type(backgroundColor[1]) == "table" then 
      love.graphics.setColor(monBt.bg[monBt.mode])
      love.graphics.circle("fill",monBt.x,monBt.y,monBt.rayon)
      else
        if monBt.mouseOver() then 
          love.graphics.setColor(1,1,1,0.7)
        else
          love.graphics.setColor(1,1,1,1)
        end
      love.graphics.draw(monBt.img,monBt.bg[monBt.mode],monBt.x,monBt.y,0,monBt.rayon/monBt.w,monBt.rayon/monBt.h,monBt.w/2,monBt.h/2)
      end
      love.graphics.setColor(monBt.txtcolor)
      love.graphics.print(monBt.txt,monBt.x,monBt.y,0,1,1,10*#monBt.txt/2,15/2)
    end
    
  end
  return monBt
end
--------------------------------------------------------------------------------------------------------------------------------------
function btRect(action,x,y,w,h,bttype,txt,backgroundColor,txtColor,img)
  -- meme chose qu'au dessus mais au lieu d'avoir un rayon on a w et h 
  monBt =  {}
  monBt.action = action or function() print('non') end
  monBt.state = false
  monBt.x = x
  monBt.y = y 
  monBt.lx = w
  monBt.ly = h
  monBt.txt = txt or ""
  monBt.type = bttype or "push"
  if type(backgroundColor) == "nil" or type(backgroundColor[1]) == "number" then
    monBt.bg = backgroundColor or {1,1,1}
    if monBt.bg[1] == 1 and monBt.bg[2] == 1 and monBt.bg[3] == 1 then
      monBt.img = img
      monBt.imgW = monBt.img:getWidth()
      monBt.imgH = monBt.img:getHeight()
    end 
  else
    if type(backgroundColor[1]) == "table" then 
      monBt.bg = backgroundColor
      monBt.mode = 1
    else
    monBt.mode = 1 
    monBt.bg = backgroundColor
    monBt.img = img 
    monBt.frame = #backgroundColor
    monBt.w = monBt.img:getWidth()
    monBt.h = monBt.img:getHeight()/monBt.frame
    end
  end
  monBt.timer = 0
  monBt.txtcolor = txtColor or {0,0,0} --if monBt.bg[1] + monBt.bg[2] + monBt.bg[3] >= 1.5 then {0,0,0} else {1,1,1} end
  monBt.mouseOver = function()
    if  monBt.x < love.mouse.getX() and love.mouse.getX() < monBt.x+ monBt.lx and monBt.y < love.mouse.getY() and love.mouse.getY() < monBt.ly+monBt.y then
      return true
    else 
      return false 
    end
  end 
  if type(monBt.bg[1]) == "number" then 
    monBt.update = function(dt)
      
      if monBt.type == "push" then
        monBt.state = false
      end
      monBt.timer = monBt.timer + dt
      if monBt.mouseOver() then
          local a = {}
          if type(backgroundColor) == "table" then
            for i = 1,#backgroundColor do
              a[i] = backgroundColor[i] 
            end
          else
            a = {1,1,1}
          end 
          if monBt.type == "push" then
            a[4] = 0.9
          end
          if love.mouse.isDown(1) then
            if monBt.type == "push" then
              a[4] = 0.6
              monBt.state = true
            elseif  monBt.timer > 0.2 then
              monBt.timer = 0
              if monBt.state then
              monBt.state = false
              a[4] = 0.6
              else 
              monBt.state = true
              a[4] = 1
              end
            end
            
          end
          if monBt.type ~= "push" then
            if monBt.state then
            a[4] = 0.6
            else 
            a[4] = 1
            end
          end
          monBt.bg = a
      else
        monBt.bg = backgroundColor or {1,1,1}
        
        if monBt.type ~= "push" then
            if monBt.state then
            monBt.bg[4] = 0.6
            else 
            monBt.bg[4] = 1
            end
          end
      end
    end
    monBt.draw = function()
      if monBt.state then
        monBt.action()
      end
      
      love.graphics.setColor(monBt.bg)
      love.graphics.rectangle("fill",monBt.x,monBt.y,monBt.lx,monBt.ly)
      if type(monBt.img) ~= "nil" then 
        love.graphics.draw(monBt.img,monBt.x,monBt.y,0,monBt.lx/monBt.imgW,monBt.ly/monBt.imgH)
      end 
      love.graphics.setColor(monBt.txtcolor)
      love.graphics.print(monBt.txt,monBt.x+monBt.lx/2,monBt.y+monBt.ly/2,0,1,1,10*#monBt.txt/2,15/2)
      love.graphics.setColor(1,1,1)
    end
    
  else 
    monBt.update = function(dt)
      monBt.timer = monBt.timer + dt
      if monBt.type == "push" then
        monBt.state = false
      end
      if monBt.mouseOver() then
        if #backgroundColor == 3 then 
          monBt.mode = 2
          if love.mouse.isDown(1) then
            monBt.mode = 3
            monBt.action()
          end
        else 
          if monBt.type == "push" then
            monBt.mode = 1
          end
          if love.mouse.isDown(1) then
            if monBt.type == "push" then
              monBt.mode = 2
              monBt.state = true
            elseif  monBt.timer > 0.2 then
                monBt.timer = 0
              if monBt.state then
                monBt.state = false
                monBt.mode = 1
              else 
                monBt.state = true
                monBt.mode = 2
              end
            end
          end
        end 
      else
        if monBt.type == "push" then
          monBt.mode = 1 
        end
      end
--      monBt.bg = bgcl
    end
    monBt.draw = function()
      if monBt.state then
        monBt.action()
      end
      if type(backgroundColor[1]) == "table" then 
      love.graphics.setColor(monBt.bg[monBt.mode])
      love.graphics.rectangle("fill",monBt.x,monBt.y,monBt.lx,monBt.ly)
      else
        if monBt.mouseOver() then 
          love.graphics.setColor(1,1,1,0.7)
        else
          love.graphics.setColor(1,1,1,1)
        end
        love.graphics.draw(monBt.img,monBt.bg[monBt.mode],monBt.x+monBt.lx/2,monBt.y+monBt.ly/2,0,math.min((monBt.lx)/monBt.w,(monBt.ly)/monBt.h),math.min((monBt.lx)/monBt.w,(monBt.ly)/monBt.h),monBt.w/2,monBt.h/2)
      end
      love.graphics.setColor(monBt.txtcolor)
      love.graphics.print(monBt.txt,monBt.x+monBt.lx/2,monBt.y+monBt.ly/2,0,1,1,10*#monBt.txt/2,15/2)
    end
    
  end
  return monBt
end