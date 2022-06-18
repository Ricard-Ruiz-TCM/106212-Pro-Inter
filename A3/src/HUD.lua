
-- Libs
local Object = Object or require "lib/classic"

-- Engine
local UIText = UIText or require "src/engine/UIText"

-- Locals
local w, h = love.graphics.getDimensions()

-- Class
local HUD = Object:extend()
-----------------------------

function HUD:new()
  self.hp = 0
  self.score_text = UIText(w - 5, 18, "Score: 0", "right", 36, {1, 1, 1, 1})
  self.hp_texture = love.graphics.newImage("assets/textures/ui/hp.png")
end

function HUD:updateHUD(data)
  self.hp = data.hp
  self.score_text:setText("Score: " .. tostring(data.score))
end

function HUD:draw()
  self.score_text:draw()
  for i = 0, self.hp - 1, 1 do
    love.graphics.draw(self.hp_texture, i * 55 + 5, 5)
  end
end

return HUD
