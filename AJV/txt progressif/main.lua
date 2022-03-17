require("FuGrEtTa")
function love.load()
  txt1 = [[fejigpokdfsf fdfdsfds dsqfsdqfqsfdqsfdsqfq fdsqf 
  fqsfgjsfsefl tfrds s
   gfdsg 
   gf
   g:]] 
  txt2 = [[murrrrlrllllr lllrglgrlgr]] 
  txtC = txtProgressif(100,100,300,5)
  txtC.add(txt1)
  txtC.add(txt2)
  print(tbprint(txtC))
end 

function love.update(dt)
  txtC.update(dt)
end 

function love.draw()
  txtC.draw()
end 



function txtProgressif(x,y,lim,limt)
  local MonTxt = {}
  MonTxt.lim = limt or 0
  MonTxt.Timer = 0
  
  MonTxt.curentTxT = ""
  
  MonTxt.listDialogues = {}
  
  
  
  MonTxt.cii = 1 
  function MonTxt.update(dt)
    MonTxt.Timer = MonTxt.Timer + 1 
    if #MonTxt.listDialogues > 0 and MonTxt.Timer >= MonTxt.lim then
      
      
      if MonTxt.curentTxT ~= MonTxt.listDialogues[1] then
        MonTxt.curentTxT = MonTxt.curentTxT.. string.sub(MonTxt.listDialogues[1],MonTxt.cii,MonTxt.cii)
        MonTxt.cii = MonTxt.cii + 1 
        MonTxt.Timer = 0
      end 
      
      if love.keyboard.isDown('space') then
        if MonTxt.curentTxT ~= MonTxt.listDialogues[1] then
          MonTxt.curentTxT = MonTxt.listDialogues[1]
          MonTxt.Timer = 0
        else
          MonTxt.curentTxT = ""
          table.remove(MonTxt.listDialogues,1) 
          MonTxt.Timer = 0
        end 
      end 
    end 
  end 
  
  function MonTxt.draw()
    if #MonTxt.listDialogues > 0 then
      love.graphics.printf(MonTxt.curentTxT,x,y,lim)
    end 
  end 
  
  function MonTxt.add(txt)
    table.insert(MonTxt.listDialogues,txt)
  end 
  
  return MonTxt
end 