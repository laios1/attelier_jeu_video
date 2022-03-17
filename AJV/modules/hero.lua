local hero = {}

hero.x = 100
hero.y = 100
hero.vx = 200
hero.vy = 0

hero.move = function(delta)
  hero.x = hero.x + hero.vx * delta
  hero.y = hero.y + hero.vy * delta
end

hero.show = function()
  love.graphics.circle("fill",hero.x,hero.y,20)
end

return hero