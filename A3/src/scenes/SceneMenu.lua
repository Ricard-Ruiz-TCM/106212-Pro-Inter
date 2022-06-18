
-- Engine
local Scene = Scene or require "src/engine/Scene"
local Entity = Entity or require "src/engine/Entity"
local UIButton = UIButton or require "src/engine/UIButton"

-- Locals
local w, h = love.graphics.getDimensions()

-- Class
local SceneMenu = Scene:extend()
--------------------------------

function SceneMenu:new()
  SceneMenu.super.new(self)
  -------------------------
  self:addEntity(Entity(w / 2, h / 2, "assets/textures/background.jpg"))
  self:addEntity(UIButton(w / 2, h / 2 - 25, "assets/textures/ui/button.png", "assets/textures/ui/button_hover.png", function() GSM:changeState("game") end, "Play", 12, {0, 0, 0}))
  self:addEntity(UIButton(w / 2, h / 2 + 25, "assets/textures/ui/button.png", "assets/textures/ui/button_hover.png", function() GSM:changeState("exit") end, "Exit", 12, {0, 0, 0}))
end

return SceneMenu
