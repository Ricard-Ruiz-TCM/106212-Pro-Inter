
-- Libs
local Vector = Vector or require "lib/vector"

-- Objects
local AInter = AInter or require "src/objects/inter/ainter"

-- DATA
DATA = DATA or require "data"

-- Singletons
Video = Video or require "src/engine/Video"

-- Class
local Wings = AInter:extend()
----------------------------

--[[ Construtor ]]
function Wings:new()
  -- Super ---------------------------------------------------------------------------------
  Wings.super.new(self, 0, 0, "inter/inter-wings", DATA.beer.speed, 1, 4, 0.2, true, "wings")
  ------------------------------------------------------------------------------------------
  
  -- Ajuste del alto de la collision Box
  self.cBox.w = self.width / 1.7
  self.cBox.h = self.cBox.h - 40
  
end

--[[ Update ]]
function Wings:update(dt)
  -- Super ------------------
  Wings.super.update(self, dt)
  ---------------------------
  
  -- Ajuste de la posicón de la collision Box
  self.cBox.x = self.cBox.x + 18
  self.cBox.y = self.cBox.y + 25
  
  -- Effecto Visual
  -- self.shearing = Vector.new(math.cos(self.time_alive * 2) - 0.5, 0)
  
end

return Wings

-----------------------------------------------------------------