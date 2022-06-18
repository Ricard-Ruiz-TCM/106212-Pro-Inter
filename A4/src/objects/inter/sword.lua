
-- Libs
local Vector = Vector or require "lib/vector"

-- Objects
local BInter = BInter or require "src/objects/inter/binter"

-- DATA
DATA = DATA or require "data"

-- Class
local Sword = BInter:extend()
-----------------------------

--[[ Construtor ]]
function Sword:new()
  -- Super ------------------------------------------------------------------
  Sword.super.new(self, 0, 0, "inter/inter-sword", DATA.sword.speed, "sword")
  ---------------------------------------------------------------------------
  
  -- Ajuste del alto de la collision Box
  self.cBox.h = self.height / 2
  
  -- Dirección de rotación
  self.dir = math.random(0, 1)
  
end

--[[ Update ]]
function Sword:update(dt)
  -- Super -------------------
  Sword.super.update(self, dt)
  ----------------------------
  
  -- Effecto de rotación de la espada
  if (self.dir == 0) then
    self.rotation = self.rotation + math.rad(self.speed * dt)
  else
    self.rotation = self.rotation - math.rad(self.speed * dt)
  end
  
  -- Ajuste de la collision box
  self.cBox.y = self.cBox.y + 25
  
end

return Sword

-----------------------------------------------------------------