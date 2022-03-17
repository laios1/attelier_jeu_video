function sci(scie,x,y,vr)
scie.x = x
scie.y = y
scie.angle = 0
scie.vangle = vr
scie.img = love.graphics.newImage("image/saw.png")
scie.h = scie.img:getHeight()
scie.w = scie.img:getWidth()
end

scie1 = {}
sci(scie1,400,300,2)

scie2 = {}
sci(scie2,400,100,20)

function love.draw()
  love.graphics.draw(scie1.img,scie1.x,scie1.y,scie1.angle,1,1,scie1.w/2,scie1.h/2)
  love.graphics.draw(scie2.img,scie2.x,scie2.y,scie2.angle,-1,1,scie2.w/2,scie2.h/2)
end

function love.update(dt)
  scie1.angle = scie1.angle + scie1.vangle * dt
  scie2.angle = scie2.angle - scie2.vangle * dt
end