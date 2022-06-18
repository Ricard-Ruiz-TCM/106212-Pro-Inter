
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

-- Locals IDS
local timer = -1
local text = -1
local intro = -1
local last = -1

local rect_alpha = 1

-- Class
local SceneIntro = Scene:extend()
----------------------------------

--[[ Constructor ]]
function SceneIntro:new(id)
  -- Super ---------------------
  SceneIntro.super.new(self, id)
  ------------------------------
  
  -- Estado de la escena
  self.state = 1
  
  -- Timer
  timer = self:addEntity(Timer(2, function() self:updateState() end, true))
  
  -- Cargamos texto
  self:addEntity(UIText(Video:width() / 2, Video:height() / 4.2, DATA.game.name, "center", 34, "assets/fonts/viking-n.ttf"))
  
  self:addEntity(UIText(Video:width() / 2, Video:height() / 1.2, "Jordi B. | Veronika B.", "center", 16, "assets/fonts/viking-n.ttf"))
  self:addEntity(UIText(Video:width() / 2, Video:height() / 1.15, "Ricard R. | Daniel S. | Blanca V.", "center", 16, "assets/fonts/viking-n.ttf"))
  
end

--[[ On Enter ]]
function SceneIntro:onEnter()
  
  -- Reload de todo
  self:reload()
  
end

--[[ Update
  @param dt -> Delta Time entre frames
--]]
function SceneIntro:update(dt)
  -- Super ------------------------
  SceneIntro.super.update(self, dt)
  ---------------------------------
  
  -- Alpha entre frames
  if (self.state <= 7) then rect_alpha = math.cos(self:getEntity(timer).time - 2) end
  if (self.state >= 7) then
    -- Movimiento molón del text
    local txt = self:getEntity(text)
    txt:move(txt.position.x, Video:height() / 1.3 + math.sin(self.time * 5) * 25)
  end
  
end

--[[ On Exit Method ]]
function SceneIntro:onExit()
  Video.background_color = {0, 0, 0, 1}
  self:removeEntity(text)
  self:removeEntity(last)
end

--[[ Render ]]
function SceneIntro:draw()
  -- Super ------------------
  SceneIntro.super.draw(self)
  ---------------------------
  love.graphics.setColor(0, 0, 0, rect_alpha)
  love.graphics.rectangle("fill", 0, 0, Video:width(), Video:height())
end

--[[ Reload ]]
function SceneIntro:reload()
  -- Super --------------------
  SceneIntro.super.reload(self)
  -----------------------------
  self.state = 1
  rect_alpha = 1
end


--[[ Input Key Pressed
  @param key -> String de la tecla pulasda
--]]
function SceneIntro:keyPressed(key)
  -- Super -----------------------------
  SceneIntro.super.keyPressed(self, key)
  --------------------------------------
  if (key == "space") then Director:changeScene("game") end
end

function SceneIntro:updateState()
  
  self.state = self.state + 1
  
  if (self.state == 2) then
    
    -- Cargamos animación intro
    intro = self:addEntity(AnimatedActor(Video:width() / 2, Video:height() / 2, "scenes/intro/intro-1-6", 0, 1, 6, 2.05, false))
    
  end
  
  if (self.state == 7) then
    
    self:removeEntity(intro)
    
    -- Cargamos animación final
    last = self:addEntity(AnimatedActor(Video:width() / 2, Video:height() / 2, "scenes/intro/intro-7-8", 0, 1, 2, 1, true))
    
    -- Cargamos texto
    text = self:addEntity(UIText(Video:width() / 2, Video:height() / 1.3, DATA.scene.intro.presstoplay, "center", 36, "assets/fonts/viking-n.ttf"))
    
  end
  
end

return SceneIntro

-----------------------------------------------------------------