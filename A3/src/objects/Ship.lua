
-- Lib
local Vector = Vector or require "lib/vector"

-- Engine
local Actor = Actor or require "src/engine/Actor"
local Timer = Timer or require "src/engine/Timer"

-- Class
local Ship = Actor:extend()
---------------------------

function Ship:new(x, y, shot)
  Ship.super.new(self, x, y, "assets/textures/playerShip1_blue.png", 0, math.rad(math.random(0, 360)))
  ------------------------------------------------------------------------
  
  self.rotateLeft = false
  self.rotateRight = false
  
  self.accelerate = false
  self.deAccelerate = false
  
  self.free = true
  
  self.hp = 3
  self.base_hp = self.hp
  self.score = 0
  self.base_score = self.score
  
  self.shot = shot
  
  self.timer = Timer(3, function() self:reSpawn() end)
  
end

function Ship:update(dt)
  Ship.super.update(self, dt)
  ---------------------------
  
  if (self:isControllable()) then
    self.forward = Vector.new(math.cos(self.rotation), math.sin(self.rotation)):normalize()
    if (self.rotateLeft == true) then self.rotation = self.rotation - math.rad(2) end
    if (self.rotateRight == true) then self.rotation = self.rotation + math.rad(2) end
    
    self.speed = self.speed - self.speed * dt * 2
    if (self.accelerate == true) then self.speed = self.speed + 10 end
    if (self.deAccelerate == true) then self.speed = self.speed - 10 end
  else
    self.rotation = self.rotation + math.rad(5)
    self.color.a = 1.25 - math.sin(self.timer.time)
  end
  
  if (self.timer:isRunning()) then self.timer:update(dt) end
  
end

function Ship:reload()
  Ship.super.reload(self)
  -----------------------
  
  self.rotateLeft = false
  self.rotateRight = false
  
  self.accelerate = false
  self.deAccelerate = false
  
  self.free = true
  self.hp = self.base_hp
  self.score = self.base_score
end

function Ship:keyPressed(key)
  Ship.super.keyPressed(self, key)
  --------------------------------
  if ((key == "space") and (self:isControllable())) then self.shot() end
  if (key == "a") then self.rotateLeft = true end
  if (key == "d") then self.rotateRight = true end
  if (key == "w") then self.accelerate = true end
  if (key == "s") then self.deAccelerate = true end
end

function Ship:keyReleased(key)
  Ship.super.keyReleased(self, key)
  ---------------------------------
  if (key == "a") then self.rotateLeft = false end
  if (key == "d") then self.rotateRight = false end
  if (key == "w") then self.accelerate = false end
  if (key == "s") then self.deAccelerate = false end
end

function Ship:increaseScore()
  self.score = self.score + 100
end

function Ship:isControllable()
  return self.free
end

function Ship:canHit()
  return self.free
end

function Ship:colAsteroid()
  self.hp = self.hp - 1
  self.free = false
  self.position = self.base_position
  self.speed = self.base_speed
  self.rotation = math.rad(math.random(0, 360))
  self.timer:reload()
end

function Ship:isDone() 
  return (self.hp <= 0)
end

function Ship:reSpawn()
  self.color.a = 1
  self.free = true
end

return Ship
