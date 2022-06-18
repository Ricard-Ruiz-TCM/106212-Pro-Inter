
-- lib
local Vector = Vector or require "lib/vector"

-- Engine
local Entity = Entity or require "src/engine/Entity"
local Actor = Actor or require "src/engine/Actor"
local Timer = Timer or require "src/engine/Timer"
local Scene = Scene or require "src/engine/Scene"
local AnimatedActor = AnimatedActor or require "src/engine/AnimatedActor"
-- UI Engine
local UIButton = UIButton or require "src/engine/UI/UIButton"
local UIText = UIText or require "src/engine/UI/UIText"

-- Singletons
Audio = Audio or require "src/engine/Audio"
Video = Video or require "src/engine/Video"
Director = Director or require "src/engine/Director"

-- DATA
DATA = DATA or require "data"

-- Objects Inter
local AInter = AInter or require "src/objects/inter/ainter"
local BInter = BInter or require "src/objects/inter/binter"
local Hammer = Hammer or require "src/objects/inter/hammer"
local Wings = Wings or require "src/objects/inter/wings"
local Lightning = Lightning or require "src/objects/inter/lightning"
local Sword = Sword or require "src/objects/inter/sword"
local Beer = Beer or require "src/objects/inter/beer"
local Rune = Rune or require "src/objects/inter/rune"

--Clouds
local Cloud = Cloud or require "src/objects/cloud"

--Background
local Background = Background or require "src/objects/background"

-- Locals IDS
local Player = Player or require "src/objects/player"

-- Class
local SceneGame = Scene:extend()
--------------------------------

 local player_id = -1
 local background_id = -1
 local indications = -1
 
 local total_time = DATA.scene.play.time

--[[ Constructor ]]
function SceneGame:new(id)
  -- Super --------------------
  SceneGame.super.new(self, id)
  -----------------------------
  
  self.timer = UIText(Video:width() / 2, 100, "", "center", 70, "assets/fonts/viking-n.ttf")
  self.timer:setColor(0, 0, 0, 1)
  
end

--[[ On Enter ]]
function SceneGame:onEnter()
  
  -- Recargamos todo al entrar a escena
  self:reload()
  
  self:addEntity(Timer(5, function() self:getEntity(indications).color.a = 0 end, false))
  
  -- Creamos los generadores
  self:addEntity(Timer(1, function() if(not self:findEntity(Player).stunned) then self:addEntity(Rune("tunnel")) end end, true))
  self:addEntity(Timer(6.1, function() if(not self:findEntity(Player).stunned) then self:addEntity(Rune("immunity")) end end, true))
  self:addEntity(Timer(2.3, function() if(not self:findEntity(Player).stunned) then self:addEntity(Beer()) end end, true))
  self:addEntity(Timer(5.2, function() if(not self:findEntity(Player).stunned) then self:addEntity(Wings()) end end , true))
  self:addEntity(Timer(7.8, function() if(not self:findEntity(Player).stunned) then self:addEntity(Hammer()) end end, true))
  self:addEntity(Timer(5.2, function() if(not self:findEntity(Player).stunned) then self:addEntity(Lightning()) end end, true))
  self:addEntity(Timer(1.4, function() if(not self:findEntity(Player).stunned) then self:addEntity(Sword()) end end , true))
  self:addEntity(Timer(1.2, function() self:addEntity(Cloud()) end, true))
  
  -- Creamos el fondo y el player
  self:addEntity(Background())
  player_id = self:addEntity(Player())
  
  indications = self:addEntity(Entity(0, 0))
  self:getEntity(indications):setTexture("wasd")
  self:getEntity(indications).scale = Vector.new(0.25, 0.25)
  self:getEntity(indications).color.a = 0.5
  
end

--[[ Update
  @param dt -> Delta Time entre frames
--]]
function SceneGame:update(dt)
  -- Super -----------------------
  SceneGame.super.update(self, dt)
  --------------------------------
  
  self:getEntity(indications).position.x = self:getEntity(player_id).position.x + 80
  self:getEntity(indications).position.y = self:getEntity(player_id).position.y + 85
  
  -- Actualizamos el timer y el texto
  total_time = total_time - dt
  self.timer:setText(tonumber(string.format("%.0f", tostring(total_time))))
  
  -- Comprobamos collisions
  self:checkCollisions()
  
  -- Comprobamos si nos quedamos sin tiepmo
  if (total_time <= 0) then 
    Director:changeScene("intro") 
  end
  
end

--[[ On Exit Method ]]
function SceneGame:onExit()
  self:removeAllEntities()
end

--[[ Render ]]
function SceneGame:draw()
  -- Super -----------------
  SceneGame.super.draw(self)
  --------------------------
  
  self:getEntity(player_id).tunnel_effect:draw()
  
  -- Pintamos el timer
  love.graphics.setColor(1, 1, 1, 0.4)
  love.graphics.rectangle("fill", self.timer.position.x - self.timer.width / 2, self.timer.position.y - self.timer.height / 2, self.timer.width, self.timer.height - 20)
  self.timer:draw()
  
end

--[[ Reload ]]
function SceneGame:reload()
  -- Super -------------------
  SceneGame.super.reload(self)
  ----------------------------
  total_time = DATA.scene.play.time
end

--[[ Input Key Pressed
  @param key -> String de la tecla pulasda
--]]
function SceneGame:keyPressed(key)
  -- Super ----------------------------
  SceneGame.super.keyPressed(self, key)
  -------------------------------------
end

-- Comprobar colisiones entre el jugador y los interactuables
function SceneGame:checkCollisions()
  local player = self:findEntity(Player)
  for i,v in ipairs(self.entities) do
    if (v:is(BInter) or v:is(AInter)) then
      if (player:intersect(v.cBox.x, v.cBox.y, v.cBox.w, v.cBox.h)) then 
        player:applyEffect(v.effect); self:removeEntity(i) end
    end
    if (v:is(Background)) then 
      if (player:intersect(v.cBox.x, v.cBox.y, v.cBox.w, v.cBox.h)) then 
        Director:changeScene("over")
      end
    end
  end
end

return SceneGame

-----------------------------------------------------------------