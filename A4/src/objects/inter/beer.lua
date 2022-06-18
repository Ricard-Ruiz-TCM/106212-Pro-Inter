
-- Libs
local Vector = Vector or require "lib/vector"

-- Objects
local AInter = AInter or require "src/objects/inter/ainter"

-- DATA
DATA = DATA or require "data"

-- Singletons
Video = Video or require "src/engine/Video"

-- Class
local Beer = AInter:extend()
----------------------------

--[[ Construtor ]]
function Beer:new()
  -- Super -------------------------------------------------------------------------------
  Beer.super.new(self, 0, 0, "inter/inter-beer", DATA.beer.speed, 1, 3, 0.2, true, "beer")
  ----------------------------------------------------------------------------------------
  
  -- Ajuste del alto de la collision Box
  self.cBox.w = self.width / 1.6
  self.cBox.h = self.cBox.h - 20
  
end

--[[ Update ]]
function Beer:update(dt)
  -- Super ------------------
  Beer.super.update(self, dt)
  ---------------------------
  
  -- Ajuste de la posicón de la collision Box
  self.cBox.x = self.cBox.x + 10
  self.cBox.y = self.cBox.y + 10
  
  -- Effecto Visual
  -- self.shearing = Vector.new(math.cos(self.time_alive * 2) - 0.5, 0)
  
end

return Beer

-----------------------------------------------------------------