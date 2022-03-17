io.stdout:setvbuf('no')

blob = {} 
blob.x = 50
blob.y = 490
blob.vx = 5
blob.vy = 0
blob.scalex = 1
blob.scalexm = 1 
--blob.vsx = 1.25
blob.scaley = 1
--blob.vsy = 1
blob.mode = 1
blob.currentTimer = 0
blob.timerMax = 0.25
blob.img = love.graphics.newImage("image/blob1.png")
blob.h = blob.img:getHeight()
blob.w = blob.img:getWidth()
blob.leScale = 1


bg = {}
bg.x = {0,800}
bg.y = {0,600,1200}
bg.cptx = 1
bg.cpty = 1
bg.img = love.graphics.newImage("image/backgrounds.jpg")
bg.w = bg.img:getWidth()
bg.h = bg.img:getHeight()

function lll(e,crx,cry,mx,my)
  if e == "p" then 
    if cry == my  and crx == mx then 
      crx = 1
      cry = 1
    elseif crx == mx then 
      cry = cry + 1
      crx = 1
    else 
      crx = crx + 1 
    end 
  else
    if cry == 1  and crx == 1 then 
      crx = mx
      cry = my
    elseif crx == 1 then 
      cry = cry - 1
      crx = mx
    else 
      crx = crx - 1 
    end 
  end
  return crx,cry
end




function love.update(dt)
  if blob.currentTimer > blob.timerMax then 
    
    blob.currentTimer = 0
  end
  blob.currentTimer = blob.currentTimer + dt
  
  
  if blob.mode == 1 then
    blob.scalex = blob.scalex - 0.1 *dt*4
    blob.scaley = blob.scaley + 0.2 *dt*4
    if blob.scalex < 1 and blob.scaley >= 1.10 then
    blob.mode = 0
    end
  else
    blob.scalex = blob.scalex + 0.1 * dt*4
    blob.scaley = blob.scaley - 0.2 * dt*4
    if blob.scalex > 1 and blob.scaley <= 0.90 then
    blob.mode = 1
    end
  end
  
  if blob.x > 800 then 
    bg.cptx,bg.cpty = lll("p",bg.cptx,bg.cpty,#bg.x,#bg.y)
    blob.x = 0
  elseif blob.x < 0 then
    bg.cptx,bg.cpty = lll("m",bg.cptx,bg.cpty,#bg.x,#bg.y)
    blob.x = 800
  end
  
  if love.keyboard.isDown('d') then
    blob.x = blob.x + blob.vx
    blob.scalexm = 1
  end 
  if love.keyboard.isDown('q') then
    blob.scalexm = -1
    blob.x = blob.x - blob.vx
  end
end

function love.draw()
  bg.quad = love.graphics.newQuad(bg.x[bg.cptx],bg.y[bg.cpty],800,600,bg.w,bg.h)
  love.graphics.draw(bg.img,bg.quad,0,0)
  love.graphics.draw(blob.img,blob.x,blob.y,0,blob.scalex*blob.scalexm*blob.leScale,blob.scaley*blob.leScale,blob.w/2,blob.h)
end



