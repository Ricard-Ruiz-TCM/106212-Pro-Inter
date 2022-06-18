
-- Lib
local Vector = Vector or require "lib/Vector"

-- Engine
local Actor = Actor or require "src/engine/Actor"

-- Locals
local w, h = love.graphics.getDimensions()

-- Class
local Paddle = Actor:extend()
-----------------------------

function Paddle:new(x, y, rotation, texture, speed)
  Paddle.super.new(self, x, y, rotation, texture, speed)
  ------------------------------------------------------
  self.score = 0
end

function Paddle:update(dt)
  Paddle.super.update(self, dt)
  -----------------------------
  
  -- World Top Limit
  if (self.position.y < 0) then
    self.position.y = 0
  end
  
  -- World Bottom Limit
  if (self.position.y > h - self.h) then
    self.position.y = h - self.h
  end
  
end

function Paddle:draw()
  Paddle.super.draw(self)
  -----------------------
end

function Paddle:reload()
  Paddle.super.reload(self)
  -------------------------
  self.score = 0
end

function Paddle:moveUp()
  self.forward = Vector.new(0, -1)
end

function Paddle:moveDown()
  self.forward = Vector.new(0, 1)
end

function Paddle:stay()
  self.forward = Vector.new(0, 0)
end

function Paddle:increaseScore()
  self.score = self.score + 1
end

function Paddle:keyPressed(key)
  Paddle.super.keyPressed(self, key)
  ----------------------------------
  if (key == "up") then
    self:moveUp()
  end
  if (key == "down") then
    self:moveDown()
  end
end

function Paddle:keyReleased(key)
  Paddle.super.keyReleased(self, key)
  -----------------------------------
  self:stay()
end

function Paddle:follow(entity)
  if (entity.position.y > self.position.y + self.h) then
    self:moveDown()
  elseif (entity.position.y < self.position.y) then
    self:moveUp()
  end
end

return Paddle
