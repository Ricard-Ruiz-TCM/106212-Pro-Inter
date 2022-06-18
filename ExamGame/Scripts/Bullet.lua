Actor = Actor or require "Scripts/actor"
local Bullet = Actor:extend()

function Bullet:new(x,y,speed,fx,fy)
  Bullet.super.new(self,"Textures/icon_bullet_gold_short.png",x,y,speed,fx,fy)
end

function Bullet:update(dt)
  Bullet.super.update(self,dt)
end

function Bullet:draw()
  local xx = self.position.x
  local ox = self.origin.x
  local yy = self.position.y
  local oy = self.origin.y
  local sx = self.scale.x
  local sy = self.scale.y
  local rr = self.rot
  love.graphics.draw(self.image,xx,yy,rr,sx,sy,ox,oy,0,0)
end

return Bullet