chrono = {}
  chrono.fontName  = "chiffres.png"
  chrono.chars     = "@ 0123456789+-:"
  chrono.spacing   = 8
  chrono.scale     = 4
  chrono.font      = love.graphics.newImageFont(  chrono.fontName , chrono.chars , chrono.spacing, chrono.scale)
largeur = love.graphics.getWidth()
hauteur = love.graphics.getHeight()

timeCrono = 0
start = true


mode = 1 
time = 0
seconde = 0

minute = 0 

heure = 0
os = -math.pi/2
om = -math.pi/2

function love.update(dt)
if start then 
time = time + dt*1
end 

seconde = math.floor(time)
os = (time*math.pi*2/60)-math.pi/2
om = (minute*math.pi*2/60)-math.pi/2



if time >= 60 then 
  minute = minute + 1 
  time = 0
end
if minute>= 60 then
  heure = heure + 1 
  minute = 0
end 

  if start == true then
  timeCrono = timeCrono + 1 
end 

end 


function love.draw()
  seconde = math.floor(time)
  if mode == 1 then 
    horloge(largeur/2,hauteur/2,100,{0,1,1})
  end 
  if mode == 2 then
    
  end 
  
  
  
end 


function horloge(x,y,t,c)
  love.graphics.setFont(chrono.font)
  love.graphics.setColor(c)
  love.graphics.circle("line", x, y, t, t)
  --love.graphics.line(x,y,x+t*math.cos(os),y+t*math.sin(os))
  --love.graphics.line(x,y,x+t*math.cos(om),y+t*math.sin(om))
  love.graphics.print(minute,x+(t-3*t/8)*math.cos(om),y+(t-3*t/8)*math.sin(om),0,1,1,43/2,32/2)
  love.graphics.print(seconde,x+(t+3*t/8)*math.cos(os),y+(t+3*t/8)*math.sin(os),0,1,1,43/2,32/2)
  
  
  for i = 1,seconde*4 do 
    local o = (0.25*i*math.pi*2/60)-math.pi/2
    love.graphics.circle("fill", x+(t+6*t/8)*math.cos(o) , y+(t+6*t/8)*math.sin(o),5)
  end 
  
  for i = 1,minute do 
    local o = (i*math.pi*2/60)-math.pi/2
    love.graphics.circle("fill", x+(t-6*t/8)*math.cos(o) , y+(t-6*t/8)*math.sin(o),5)
  end 
  
  love.graphics.setFont(love.graphics.newFont(20))
  love.graphics.setColor(1,1,1)
  if heure >= 1 then 
    love.graphics.print("wow t'as atendu ".. heure .." heures !!!! (ou alors t'as triché /(ToT)/ ) ",x-t*2.5,y-t*2.5)
  end 
  
end 





function love.keyreleased(key)
if key == "s" then
  start = true
end
if key == "z" then
  start = false
end 
end 

