
-- Libs
local Vector = Vector or require "lib/vector"

-- Engine
local Entity = Entity or require "src/engine/Entity"

-- Objects
local BInter = BInter or require "src/objects/inter/binter"

-- DATA
DATA = DATA or require "data"

-- Singletons
Video = Video or require "src/engine/Video"

-- Class
local Rune = BInter:extend()
------------------------------

--[[ Construtor ]]
function Rune:new(effect)
  -- Super ----------------------------------------------------------------
  Rune.super.new(self, 0, 0, "inter/inter-rune-i", DATA.rune.speed, effect)
  -------------------------------------------------------------------------
  
  -- Runa Blanca
  if (effect == "immunity") then self:setTexture("inter/inter-rune-i") end
  
  -- Runa Roja
  if (effect == "tunnel") then self:setTexture("inter/inter-rune-t") end
    
  -- Creamos el effecto de aura
  self.aura = Entity(self.position.x, self.position.y)
  self.aura:setTexture("inter/inter-rune-aura")
  
  -- Ajuste de escala
  self.scale = Vector.new(0.6, 0.6)
  
  -- Ajuste de la collision Box
  self.cBox = {x = self.position.x, y = self.position.y, w = self.width / 2.2, h = self.height / 2.5}
  
end

--[[ Update ]]
function Rune:update(dt)
  -- Super ------------------
  Rune.super.update(self, dt)
  ---------------------------
  
  -- Ajuste de la collision Box
  if (self.effect == "tunnel") then
    self.cBox.x = self.cBox.x + 22
    self.cBox.y = self.cBox.y + 40
  elseif (self.effect == "immunity") then
    self.cBox.x = self.cBox.x + 20
    self.cBox.y = self.cBox.y + 45
  end
  
  -- Update de la posición y effecto
  self.aura.position = self.position
  self.aura.rotation = self.aura.rotation + math.rad(self.speed * dt)
  
end

--[[ Draw ]]
function Rune:draw()
  
  -- Render del effecto
  self.aura:draw()
  
  -- Super ------------
  Rune.super.draw(self)
  ---------------------
end

return Rune

-----------------------------------------------------------------