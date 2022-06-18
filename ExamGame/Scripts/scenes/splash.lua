
local Object = Object or require "Scripts/object"

local Splash = Object:extend()

local w,h = love.graphics.getDimensions()

function Splash:new()
  self.time = 5
end

function Splash:update(dt)
  self.time = self.time - dt
  if (self.time <= 0) then global_current_scene = 2 end
end

function Splash:draw()
  love.graphics.print("EQUIPO DE RESCATE", w / 2 - 100, 200)
  love.graphics.print("SPLASH SCREEN " .. tostring(self.time), w / 2 - 150, h / 2)
end


return Splash