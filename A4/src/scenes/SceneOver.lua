
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

-- Locals IDS
local tcontroler = -1
local text = -1
local over = -1
local last = -1
local extraTXT = -1

local rect_alpha = 1

-- Class
local SceneOver = Scene:extend()
--------------------------------

--[[ Constructor ]]
function SceneOver:new(id)
  -- Super --------------------
  SceneOver.super.new(self, id)
  -----------------------------
  
  -- Estado de la escena
  self.state = -1
  
  -- Timer
  tcontroler = self:addEntity(Timer(1, function() self:updateState() end, true))
  
  -- Cargamos texto
  self:addEntity(UIText(Video:width() / 2, Video:height() / 4.2, DATA.game.name, "center", 34, "assets/fonts/viking-n.ttf"))
  
  self:addEntity(UIText(Video:width() / 2, Video:height() / 1.2, "Jordi B. | Veronika B.", "center", 16, "assets/fonts/viking-n.ttf"))
  self:addEntity(UIText(Video:width() / 2, Video:height() / 1.15, "Ricard R. | Daniel S. | Blanca V.", "center", 16, "assets/fonts/viking-n.ttf"))
  
end

--[[ On Enter ]]
function SceneOver:onEnter()
  
  -- Reload de todo
  self:reload()
  
  -- Cargamos la anmiación final
  over = self:addEntity(AnimatedActor(Video:width() / 2, Video:height() / 2, "scenes/over/over-1-10", 0, 1, 10, 1.01, false))
  
end

--[[ Update
  @param dt -> Delta Time entre frames
--]]
function SceneOver:update(dt)
  -- Super -----------------------
  SceneOver.super.update(self, dt)
  --------------------------------
  
  -- Alpha entre frames
  if (self.state <= 10) then rect_alpha = math.cos(self:getEntity(tcontroler).time - 2) end
  if (self.state >= 10) then
    -- Movimiento molon del texto
    local txt = self:getEntity(text)
    txt:move(txt.position.x, Video:height() / 1.3 + math.sin(self.time * 5) * 25)
    local etxt = self:getEntity(extraTXT)
    etxt:move(etxt.position.x, Video:height() / 1.25 + math.sin(self.time * 5) * 25)
  end
  
end

--[[ On Exit Method ]]
function SceneOver:onExit()
  self:removeEntity(extraTXT)
  self:removeEntity(text)
  self:removeEntity(last)
end

--[[ Render ]]
function SceneOver:draw()
  -- Super -----------------
  SceneOver.super.draw(self)
  --------------------------
  love.graphics.setColor(0, 0, 0, rect_alpha)
  love.graphics.rectangle("fill", 0, 0, Video:width(), Video:height())
end

--[[ Reload ]]
function SceneOver:reload()
  -- Super -------------------
  SceneOver.super.reload(self)
  ----------------------------
  self.state = 1
  rect_alpha = 1
end

--[[ Input Key Pressed
  @param key -> String de la tecla pulasda
--]]
function SceneOver:keyPressed(key)
  -- Super ----------------------------
  SceneOver.super.keyPressed(self, key)
  -------------------------------------
  if (key == "space") then Director:changeScene("intro") end
end

function SceneOver:updateState()
  
  self.state = self.state + 1

  if (self.state == 10) then
    
    self:removeEntity(over)
    
    -- Cargamos el frame final
    last = self:addEntity(Entity(Video:width() / 2, Video:height() / 2))
    self:getEntity(last):setTexture("scenes/over/over-11")
    
    -- Cargamos los textos
    text = self:addEntity(UIText(Video:width() / 2, Video:height() / 1.3, DATA.scene.over.thanks, "center", 32, "assets/fonts/viking-n.ttf"))
    extraTXT = self:addEntity(UIText(Video:width() / 2, Video:height() / 1.25, DATA.scene.over.presstoplay, "center", 28, "assets/fonts/viking-n.ttf"))
    
  end
  
end


return SceneOver

-----------------------------------------------------------------