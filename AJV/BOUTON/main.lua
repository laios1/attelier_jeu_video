io.stdout:setvbuf('no')
largeur = love.graphics.getWidth()
hauteur = love.graphics.getHeight()

maFont = love.graphics.newFont("pixel.ttf",15)
love.graphics.setFont(maFont)

require("gui")


bt1 = {} 
bt1.imgs =  {{1,0,0},{237/255,127/255,16/255},{137/255,227/255,16/255}}
function bt1.action() 
  love.event.quit()
end

switch = {}
switch.img = love.graphics.newImage("switch.png")
switch.quads = {love.graphics.newQuad(0,0,switch.img:getWidth(),switch.img:getHeight()/2,switch.img:getWidth(),switch.img:getHeight()), 
                love.graphics.newQuad(0,switch.img:getHeight()/2,switch.img:getWidth(),switch.img:getHeight()/2,switch.img:getWidth(),switch.img:getHeight())}

jauge = {}
jauge.start = false 
jauge.x = largeur/2
jauge.y = hauteur/2 -100
jauge.w = 50
jauge.h = 200
jauge.liqx = jauge.x
jauge.liqy = jauge.y
jauge.liqh = 0
jauge.vert = {137/255,227/255,16/255}
jauge.bleu = {17/255,17/255,162/255}
jauge.currentcolor = jauge.vert 
jauge.vit = 0.4
jauge.draw = function()
  love.graphics.rectangle("fill",jauge.x,jauge.y,jauge.w,-jauge.h)
  love.graphics.setColor(jauge.currentcolor)
  love.graphics.rectangle("fill",jauge.liqx,jauge.liqy,jauge.w,-jauge.liqh)
end
jauge.update = function()
  if jauge.start then
    jauge.liqh = jauge.liqh + jauge.vit
    if jauge.liqh >= jauge.h then
      jauge.liqh = 0 
    end
  end
end
jauge.toblue = true
jauge.tobluef = function()
  jauge.toblue = true
end
jauge.ChangeColor = function()
  jauge.currentcolor = jauge.vert 
  jauge.toblue = false
end


bt1 = btRond(bt1.action,largeur-50,hauteur-50,50,"push","quit",bt1.imgs,{0,1,0},_,_)
bt2 = btRect(_,largeur/2-50,hauteur/2-25,100,50,"push","NON",{0,0,1},{0,1,0})
switch = btRect(jauge.tobluef,switch.img:getWidth()/2,hauteur-switch.img:getHeight(),switch.img:getWidth(),switch.img:getHeight(),"switch",_,switch.quads,_,switch.img) 

function love.update(dt)
  
  bt1.update(dt)
  bt2.update(dt)
  switch.update(dt)
  jauge.update()
end


function love.draw()
  bt1.draw()
  bt2.draw()
  switch.draw()
  jauge.draw()
end