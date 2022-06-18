
-- Libs
local Vector = Vector or require "lib/vector"

-- Objects
local AInter = AInter or require "src/objects/inter/ainter"

-- DATA
DATA = DATA or require "data"

-- Class
local Lightning = AInter:extend()
---------------------------------

--[[ Construtor ]]
function Lightning:new()
  -- Super ----------------------------------------------------------------------------------------------------
  Lightning.super.new(self, 0, 0, "inter/inter-lightning", DATA.lightning.speed, 1, 5, 0.5, false, "lightning")
  -------------------------------------------------------------------------------------------------------------
  
  -- Set de posición más acorde
  self.position = Vector.new(math.random(self.width / self.total_frames, Video:width()), math.random(0, Video:height() - (self.height / self.total_animations)))
  
  self.cBox.w = self.cBox.w / 4.5
  
end

--[[ Update ]]
function Lightning:update(dt)
  -- Super -----------------------
  Lightning.super.update(self, dt)
  --------------------------------
  
  -- Forzamos velocidad del rayo a más potencia
  if (self.frame == 2) then 
    self.frame_rate = 0.1
  end
  
  -- Ajsute de la collision Box
  if (self.frame < 4) then self.cBox.x = -100 else self.cBox.x = self.cBox.x + self.width / 2.5 end
  
  -- Destroy
  if (self:animFinished()) then self:destroy() end
  
end

return Lightning

-----------------------------------------------------------------