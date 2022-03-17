lstTuyaux = {}
tvx = 150
function addTuyau()
  local tuyau = {}
  tuyau.hautImg = tuyauHaut
  tuyau.basImg = tuyauBas
  tuyau.w = tuyau.hautImg:getWidth()
  tuyau.h = tuyau.hautImg:getHeight()
  tuyau.espace = 150
  tuyau.x = winW
  tuyau.hauty = -math.random(350)
  tuyau.basy = tuyau.hauty + tuyau.h + tuyau.espace 
  tuyau.vx = tvx
  
  function tuyau.move(dt)
    tuyau.x = tuyau.x - tuyau.vx * dt
  end 
  
  function tuyau.draw()
    love.graphics.draw(tuyau.hautImg,tuyau.x,tuyau.hauty)
    love.graphics.draw(tuyau.basImg,tuyau.x,tuyau.basy)
  end 
  
  table.insert(lstTuyaux,tuyau)
  
end 