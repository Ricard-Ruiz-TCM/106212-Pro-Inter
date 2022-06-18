
-- Engine
local Scene = Scene or require "src/engine/Scene"
local Timer = Timer or require "src/engine/Timer"
local UIText = UIText or require "src/engine/UIText"

-- Locals
local splash_text_id = -1

local w, h = love.graphics.getDimensions()

-- Class
local SceneSplash = Scene:extend()
----------------------------------

function SceneSplash:new()
  SceneSplash.super.new(self)
  ---------------------------
  self:addEntity(Timer(5, function() GSM:changeState("menu") end))
  splash_text_id = self:addEntity(UIText(w / 2, h / 3, "", "center", 32))
end

function SceneSplash:update(dt)
  SceneSplash.super.update(self, dt)
  ----------------------------------
  local st = self:getEntity(splash_text_id)
  st:setText("HOLA, SOY UNA MOLESTA SPLASH SCREEN\n           ME VOY EN " .. (5-self.time))
  st:changePosition(st.position.x, st.position.y + math.sin(self.time * 2.5) * 5)
end

return SceneSplash
