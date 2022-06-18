
-- Lib
local Vector = Vector or require "lib/vector"

-- Engine
local Actor = Actor or require "src/engine/Actor"
local SimpleAudio = SimpleAudio or require "src/engine/SimpleAudio"

-- Locals
local w, h = love.graphics.getDimensions()

-- Class
local Ball = Actor:extend()
---------------------------

function Ball:new(x, y, rotation, texture, speed)
  Ball.super.new(self, x, y, rotation, texture, speed)
  ----------------------------------------------------
  
  -- 1 up left, 2 up right, 3 down right, 4 down left
  -- 1 -> 225º, 2 -> 315º, 3 -> 45º, 4 -> 135º
  self.state = 0
  
  self:start()
end

function Ball:update(dt)
  Ball.super.update(self, dt)
  ---------------------------
  
  -- Update Forward Vector based on self.rotation
  self.forward = Vector.new(math.cos(self.rotation), math.sin(self.rotation)):normalize()
  
  -- World Top Limit
  if (self.position.y < self.w) then
    SimpleAudio:playAudio("ball_map_bounce")
    if (self.state == 1) then
      self.state = 4
      self.rotation = math.rad(135)
    elseif (self.state == 2) then
      self.state = 3
      self.rotation = math.rad(45)
    end
  end
  
  -- World Bottom Limit
  if (self.position.y > h - self.w) then
    SimpleAudio:playAudio("ball_map_bounce")
    if (self.state == 3) then
      self.state = 2
      self.rotation = math.rad(315)
    elseif (self.state == 4) then
      self.state = 1
      self.rotation = math.rad(225)
    end
  end

end

function Ball:draw()
  Ball.super.draw(self)
  ---------------------
end

function Ball:reload()
  Ball.super.reload(self)
  -----------------------
  self:start()
end

function Ball:start()
  self.state = math.random(1, 4)
  local deg = {225, 315, 45, 135}
  self.rotation = math.rad(math.random(deg[self.state] - 22.5, deg[self.state] + 22.5))
end

function Ball:paddleCollision()
  
  self:increaseSpeed()
  
  -- Left Paddle
  if (self.position.x < w / 2) then
    if (self.state == 4) then
      self.state = 3
      self.rotation = math.rad(45)
    elseif (self.state == 1) then
      self.state = 2
      self.rotation = math.rad(315)
    end
  end
  
  -- Right Paddle
  if (self.position.x > w / 2) then
    if (self.state == 2) then
      self.state = 1
      self.rotation = math.rad(225)
    elseif (self.state == 3) then
      self.state = 4
      self.rotation = math.rad(135)
    end
  end
  
end

function Ball:leftLimit()
  return (self.position.x < self.w)
end  

function Ball:rightLimit()
    return (self.position.x > w - self.w)
end

function Ball:increaseSpeed()
  self.speed = self.speed + 25
end

return Ball
