local Actor = Actor or require "Scripts/actor"
local Asteroid = Actor:extend()
local Vector = Vector or require "Scripts/vector"

local w, h = love.graphics.getDimensions()

function Asteroid:new(x,y)
  Asteroid.super.new(self,"Textures/Meteors/meteorBrown_big" .. math.random(1, 4) .. ".png", 0, 0, 0, 1, 0)
  self:init()
end

function Asteroid:update(dt)
    Asteroid.super.update(self,dt)
    
    self.rot = self.rot + self.rSpeed * dt
    
    if ((self.position.x - self.width > w) or (self.position.x + self.width < 0) or (self.position.y - self.height > h) or (self.position.y + self.height < 0)) then
      self:init()
    end
    
end

function Asteroid:draw()
  local xx = self.position.x
  local ox = self.origin.x
  local yy = self.position.y
  local oy = self.origin.y
  local sx = self.scale.x
  local sy = self.scale.y
  local rr = self.rot
  love.graphics.draw(self.image,xx,yy,rr,sx,sy,ox,oy,0,0)
end

function Asteroid:init()
    self.position = Vector.new(math.random(0, w), math.random(0, h))
    self.forward = Vector.new(math.random(-100, 100) / 100, math.random(-100, 100) / 100)
    self.rSpeed = math.random(-30, 30)/15
    self.speed = math.random(20, 80)
end

return Asteroid
