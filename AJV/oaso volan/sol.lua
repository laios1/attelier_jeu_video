sol = {}

sol.x = 0 
sol.img = solimg
sol.h = sol.img:getHeight()
sol.w = sol.img:getWidth()
sol.y = winH - sol.h 
sol.vx = 150

function sol.update(dt)
  sol.x = sol.x - sol.vx *dt
  if sol.x < -sol.w then 
    sol.x = 0
  end 
end 

function sol.draw()
  love.graphics.draw(sol.img,sol.x,sol.y)
  love.graphics.draw(sol.img,sol.x+sol.w,sol.y)
end 