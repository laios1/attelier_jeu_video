flappy = {}

flappy.x = 150
flappy.y = winH*0.4

flappy.vy = 0 
flappy.ay = 0
flappy.Fext = 0 
flappy.rotation = 0 
flappy.bounce = -30000
flappy.img = flappyImg
flappy.w = flappy.img:getWidth()
flappy.h = flappy.img:getHeight()


function flappy.applyForce(pf) 
  flappy.Fext = flappy.Fext + pf 
end 

function flappy.move(dt) 
  flappy.ay = flappy.Fext 
  flappy.vy = flappy.vy + flappy.ay * dt
  flappy.y  = flappy.y  + flappy.vy * dt
  flappy.Fext = 0
end 

function flappy.update(dt)
  flappy.applyForce(gravity) 
  flappy.move(dt)
end 

function flappy.draw() 
  love.graphics.draw(flappyImg,flappy.x,flappy.y,flappy.rotation)
end 

function flappy.collideSol(pSol)
  return flappy.y + flappy.h > pSol.y 
end 

function flappy.collideT(pTuyau)
  if collideSquare({flappy.x,flappy.y,flappy.w,flappy.h},{pTuyau.x,pTuyau.hauty,pTuyau.w,pTuyau.h}) or collideSquare({flappy.x,flappy.y,flappy.w,flappy.h},{pTuyau.x,pTuyau.basy,pTuyau.w,pTuyau.h}) then 
    return true
  end
end 

function collideSquare(c1,c2)
  if c1[1] + c1[3] > c2[1] and c1[1] < c2[1] + c2[3] and c1[2] + c1[4] > c2[2] and c1[2] < c2[2] + c2[4] then
    return true 
  else
    return false
  end 
end 

