function btRond(action,x,y,r,bttype,t,bgcl,tcl,img,monBt)
  monBt = monBt or {}
  monBt.action = action or function() print('non') end
  monBt.state = false
  monBt.rayon = r
  monBt.x = x
  monBt.y = y 
  monBt.txt = t or ""
  monBt.type = bttype or "push"
  if type(bgcl) == "nil" or type(bgcl[1]) == "number" then
    monBt.bg = bgcl or {1,1,1}
  else
    if type(bgcl[1]) == "table" then 
      monBt.bg = bgcl
      monBt.mode = 1
    else
      monBt.mode = 1 
      monBt.bg = bgcl
      monBt.img = img 
      monBt.frame = #bgcl
      monBt.w = monBt.img:getWidth()
      monBt.h = monBt.img:getHeight()/monBt.frame
    end
  end
  monBt.timer = 0
  monBt.txtcolor = tcl or {0,0,0} --if monBt.bg[1] + monBt.bg[2] + monBt.bg[3] >= 1.5 then {0,0,0} else {1,1,1} end
  monBt.mouseOver = function()
    if ((monBt.x - love.mouse.getX())^2 + (monBt.y - love.mouse.getY())^2)^0.5 <= r then
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
          if type(bgcl) == "table" then
            for i = 1,#bgcl do
              a[i] = bgcl[i] 
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
        monBt.bg = bgcl or {1,1,1}
        
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
        if #bgcl == 3 then 
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
      if type(bgcl[1]) == "table" then 
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
function btRect(action,x,y,w,h,bttype,t,bgcl,tcl,img,monBt)
  monBt = monBt or {}
  monBt.action = action or function() print('non') end
  monBt.state = false
  monBt.x = x
  monBt.y = y 
  monBt.lx = w
  monBt.ly = h
  monBt.txt = t or ""
  monBt.type = bttype or "push"
  if type(bgcl) == "nil" or type(bgcl[1]) == "number" then
    monBt.bg = bgcl or {1,1,1}
  else
    if type(bgcl[1]) == "table" then 
      monBt.bg = bgcl
      monBt.mode = 1
    else
    monBt.mode = 1 
    monBt.bg = bgcl
    monBt.img = img 
    monBt.frame = #bgcl
    monBt.w = monBt.img:getWidth()
    monBt.h = monBt.img:getHeight()/monBt.frame
    end
  end
  monBt.timer = 0
  monBt.txtcolor = tcl or {0,0,0} --if monBt.bg[1] + monBt.bg[2] + monBt.bg[3] >= 1.5 then {0,0,0} else {1,1,1} end
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
          if type(bgcl) == "table" then
            for i = 1,#bgcl do
              a[i] = bgcl[i] 
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
        monBt.bg = bgcl or {1,1,1}
        
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
        if #bgcl == 3 then 
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
      if type(bgcl[1]) == "table" then 
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