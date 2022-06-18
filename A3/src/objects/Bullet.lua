
-- Libs
local Vector = Vector or require "lib/vector"

-- Engine
local Actor = Actor or require "src/Engine/Actor"

-- Locals
local w, h = love.graphics.getDimensions()

-- Class
local Bullet = Actor:extend()
-------------------------------------

function Bullet:new(x, y, rotation)
  Bullet.super.new(self, x, y, "assets/textures/bullet.png", 500, rotation)
  -----------------------------------------------
  self.forward = Vector.new(math.cos(self.rotation), math.sin(self.rotation)):normalize()
  self.position = self.position + self.forward * 45
end

function Bullet:update(dt)
  Bullet.super.update(self, dt)
  -----------------------------
  if (self:outScreen()) then self:destroy() end
end

return Bullet
