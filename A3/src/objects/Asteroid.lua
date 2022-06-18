
-- Libs
local Vector = Vector or require "lib/vector"

-- Engine
local Actor = Actor or require "src/Engine/Actor"

-- Locals
local w, h = love.graphics.getDimensions()

-- Class
local Asteroid = Actor:extend()
-------------------------------

function Asteroid:new()
  Asteroid.super.new(self, 0, 0, "assets/textures/Meteors/meteorBrown_big" .. math.random(1, 4) .. ".png", 0)
  -----------------------------------------------------------------------------------------------------------
  self:reAlloc()
end

function Asteroid:update(dt)
  Asteroid.super.update(self, dt)
  -------------------------------
  self.rotation = self.rotation + self.rotation_speed * dt
  if (self:outScreen()) then self:reAlloc() end
end

function Asteroid:reAlloc()
  self.position = Vector.new(math.random(0, w), math.random(0, h))
  self.forward = Vector.new(math.random(-100, 100) / 100, math.random(-100, 100) / 100)
  self.rotation_speed = math.random(-30, 30)/15
  self.speed = math.random(20, 80)
end

return Asteroid
