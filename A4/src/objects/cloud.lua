--Engine
local Actor = Actor or require "src/engine/Actor"

--Lib
local Vector = Vector or require "lib/vector"

-- Singletons
Video = Video or require "src/engine/Video"

-- DATA
DATA = DATA or require "data"

local Cloud = Actor:extend()
local time = 0
function Cloud:new()
  Cloud.super.new(self, math.random(0,600), math.random(-10,0), "scenes/play/nubes/"..math.random(1,5), math.random(50, 70))
  local s = math.random(100, 900) / 1000
  self.scale = Vector.new(s,s)
  self.dir = 0
  if (self.position.x > Video:width() / 2) then self.dir = 1 end
  self.speed = DATA.cloud.speed * self.scale.x
  self.color.a = self.scale.x + 0.2
end

function Cloud:update(dt)
  Cloud.super.update(self,dt)

  local s = math.max(DATA.global.min_speed, DATA.global.speed)
  
  self.position.y = self.position.y + s * 2.5 * self.scale.x*dt
  
  if (self.dir == 0) then 
    self.position.x = self.position.x + self.speed*0.75*dt
  elseif (self.dir == 1) then
    self.position.x = self.position.x - self.speed*0.75*dt
  end
  time = time + dt
  if time > 5 then
    if (self.position.y > Video:height() + (self.height * 2)) then 
      self:destroy() 
    end
    if (self.position.y < -(self.height * 2)) then 
      self:destroy() 
    end
  end
  
end

function Cloud:draw()
  Cloud.super.draw(self)
end

return Cloud