time = 50
seconde = 0
minute = 0 



function love.update(dt)
time = time + dt
end 


function love.draw()
  seconde = math.floor(time)
 love.graphics.print(minute.." min "..seconde.." sec",0,0)
if time >= 60 then 
  minute = minute + 1 
  time = 0
end
end 
