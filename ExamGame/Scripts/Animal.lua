Actor = Actor or require "Scripts/Actor"
local Animal = Actor:extend()
Vector = Vector or require "Scripts/vector"
Bullet = Bullet or require "Scripts/Bullet"

local w,h = love.graphics.getDimensions()

function Animal:new(time)
  self.type = math.random(1, 30)
  Animal.super.new(self,"Textures/Animals/" .. tostring(self.type) .. ".png", math.random(0, w), math.random(0, 64) , 10, 0, 1)
  self.alive = true
  self.rescued_by_ship = false
  self.time = time or 10
end

function Animal:update(dt)
  
  if (self.alive) then
    
    if (not self.rescued_by_ship) then
      self.time = self.time - dt
      if (self.time <= 0) then self.alive = false end
    end
    
  end
    
end

function Animal:draw()
  local xx = self.position.x
  local ox = self.origin.x
  local yy = self.position.y
  local oy = self.origin.y
  local sx = self.scale.x
  local sy = self.scale.y
  local rr = self.rot
  love.graphics.draw(self.image,xx,yy,rr,sx,sy,ox,oy,0,0)
end

function Animal:rescued()
  self.rescued_by_ship = true
  self.scale.x = 0.5
  self.scale.y = 0.5
end


return Animal