--Lib
local Vector = Vector or require "lib/vector"

--Engine
local Entity = Entity or require "src/engine/Entity"

-- Singleton
Video = Video or require "src/engine/Video"

-- DATA
DATA = DATA or require "data"

-- Class
local Background = Entity:extend()
---------------------------------

function Background:new()
  -- Super --------------------------------------------------------
  Background.super.new(self, Video:width() / 2, Video:height() / 2)
  -----------------------------------------------------------------
  self:setTexture("scenes/play/background")
  
  self.start = Entity(self.position.x, self.position.y)
  self.start:setTexture("scenes/play/backrground_ground")
  
  self.last = Entity(self.position.x, -10000)
  self.last:setTexture("scenes/play/background_final")
  
  self.cBox = {x = 0, y = 0, w = Video:width(), h = Video:height() / 2}
  
end

function Background:update(dt)
  -- Super ------------------------
  Background.super.update(self, dt)
  ---------------------------------
  
  local s = math.max(DATA.global.min_speed, DATA.global.speed)
  
  if (self.last.position.y >= self.last.height / 2) then
    s = 0
  end
  
  -- Update del inicio
  if (self.start.position.y <= Video:height() * 2) then self.start.position.y = self.start.position.y + s * dt end
  
  -- Update del final
  if (self.last.position.y >= self.last.height / 2) then
    self.last.position.y = Video:height() / 2
    DATA.global.speed = 0 
  else
    self.last.position.y = self.last.position.y + s * dt
  end
  
  -- Ajuste d collision box del final
  self.cBox.y = self.last.position.y - self.last.height / 2
  
end

function Background:draw()
  -- Super ------------------
  Background.super.draw(self)
  ---------------------------
  
  if (self.start.position.y <= Video:height() * 2) then self.start:draw() end
  
  if (self.last.position.y + self.last.height >= 0) then self.last:draw() end
  
end


return Background