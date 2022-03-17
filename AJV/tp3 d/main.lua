DVD = love.graphics.newImage("image/DVD.png")
largeurDVD = DVD:getWidth()
hauteurDVD = DVD:getHeight()

scx = 0.25
scxt = true
an = 0
largeur = love.graphics.getWidth()
hauteur = love.graphics.getHeight()


vx = math.random()*10
vy = math.random()*10
x = largeur/2
y = hauteur/2


if math.random() % 2 == 0 then
  d = true
  g = false
else 
  d = false
  g = true
end
if math.random() % 2 == 0 then
  h = true
  b = false
else 
  h = false
  b = true
end



function love.draw()
  love.graphics.draw(DVD,x,y,an,scx,scx,largeurDVD/2,hauteurDVD/2)
end 

function love.update(dt)
largeur = love.graphics.getWidth()
hauteur = love.graphics.getHeight()
an = an+0
if scxt then
  scx = scx + 0.01
else 
  scx = scx - 0.01
end 
if scx >= 1 then
  scxt = false  
elseif scx <= 0.1 then
  scxt = true
end


dehors()
droite(vx)
gauche(vx)
haut(vy)
bas(vy)


end

function dehors()
  if x-(largeurDVD/2)*scx <= 0 then
    g = false
    d = true  
  elseif x+(largeurDVD/2)*scx >= largeur then
    g = true
    d = false
  end 
  if y-(hauteurDVD/2)*scx <= 0 then
    h = false
    b = true  
  elseif y+(hauteurDVD/2)*scx >= hauteur then
    h = true
    b = false
  end 
end 


function droite(v)
  if d then
    x = x+v
  end 
  
end 

function gauche(v)
  if g then
    x = x-v
  end 
end 

function haut(v)
  if h then
    y = y-v
  end 
end 

function bas(v)
  if b then
    y = y+v
  end 
end 
