chrono = {}
  chrono.fontName  = "chiffres.png"
  chrono.chars     = "@ 0123456789+-:"
  chrono.spacing   = 8
  chrono.font      = love.graphics.newImageFont(  chrono.fontName , chrono.chars , chrono.spacing)
largeur = love.graphics.getWidth()
hauteur = love.graphics.getHeight()




mode = 1 
time = 0
seconde = 0
minute = 0 
heure = 0
os = -math.pi/2
om = -math.pi/2

r = heure
g = minute
b = seconde

function love.update(dt)
time = time + dt*1
os = (time*math.pi*2/255)-math.pi/2
om = (minute*math.pi*2/255)-math.pi/2

if time >= 255 then 
  minute = minute + 1 
  time = 0
end
if minute>= 255 then
  heure = heure + 1 
  minute = 0
end 

r = heure
g = minute
b = seconde

end 


function love.draw()
  seconde = math.floor(time)
  
  horloge(largeur/2,hauteur/2,100,{1,1,1})
  love.graphics.setBackgroundColor( r/255, g/255, b/255)
  love.graphics.print("#"..string.format("%x", r)..""..string.format("%x", g)..""..string.format("%x", b),largeur/2,hauteur*4/5)
end 


function horloge(x,y,t,c)
  love.graphics.setFont(chrono.font)
  love.graphics.setColor(c)
  love.graphics.circle("line", x, y, t, t)
  love.graphics.line(x,y,x+t*math.cos(os),y+t*math.sin(os))
  love.graphics.line(x,y,x+t*math.cos(om),y+t*math.sin(om))
  love.graphics.setFont(love.graphics.newFont(20))
  love.graphics.setColor(1,1,1)
  if heure >= 1 then 
    love.graphics.print("wow t'as atendu ".. heure .." heures !!!! (ou alors t'as triché /(ToT)/ ) ",x-t*2.5,y-t*2)
  end 
end 



function base16(x)
  string.format("%x", x)
end