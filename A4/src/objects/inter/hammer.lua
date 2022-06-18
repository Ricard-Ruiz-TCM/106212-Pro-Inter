
-- Libs
local Vector = Vector or require "lib/vector"

-- Objects
local AInter = AInter or require "src/objects/inter/ainter"

-- DATA
DATA = DATA or require "data"

-- Singletons
Video = Video or require "src/engine/Video"

-- Class
local Hammer = AInter:extend()
------------------------------

--[[ Construtor ]]
function Hammer:new()
  -- Super ----------------------------------------------------------------------------------------
  Hammer.super.new(self, 0, 0, "inter/inter-hammer", DATA.hammer.speed, 1, 3, 0.8, false, "hammer")
  -------------------------------------------------------------------------------------------------
  
  -- Ajuste del alto de la collision Box
  self.cBox.h = self.height / 3.2
  
end

--[[ Update ]]
function Hammer:update(dt)
  -- Super --------------------
  Hammer.super.update(self, dt)
  -----------------------------
  
  if (self.up) then self.speed = -math.max(DATA.global.speed, DATA.global.min_speed) end
  
  -- Ajuste de la collision Box
  if (self.scale.y < 0) then 
    self.cBox.y = self.cBox.y + 2
  else 
    self.cBox.y = self.cBox.y + 65
  end
  
  -- Cambiamos dirección y "rotación" si llega al límite de la pantalla
  if (self.position.y > Video:height()) then self.up = true; self.scale.y = -1; self:reset() end
  
end

return Hammer

-----------------------------------------------------------------