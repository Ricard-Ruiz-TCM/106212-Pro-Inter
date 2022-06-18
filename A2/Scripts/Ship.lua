local Actor = Actor or require "Scripts/actor"
local Ship = Actor:extend()

local Vector = Vector or require "Scripts/vector"

function Ship:new(x,y)
  Ship.super.new(self,"Textures/playerShip1_blue.png",400,300,50,1,0)
  
  Ship.rotateLeft = false
  Ship.rotateRight = false
  
  Ship.accelerate = false
  Ship.deAccelerate = false
  
end

function Ship:update(dt)
  Ship.super.update(self,dt)

  if (self.rotateLeft == true) then
    self.rot = self.rot - math.rad(2)
  end
  
  if (self.rotateRight == true) then
    self.rot = self.rot + math.rad(2)
  end
  
  -- Rotate forward vector based on rotation
  self.forward = Vector.new(math.cos(self.rot), math.sin(self.rot)):normalize()
  
  self.speed = self.speed - self.speed * dt
  
  if (self.accelerate == true) then
    self.speed = self.speed + 5
  end
  
  if (self.deAccelerate == true) then
    self.speed = self.speed - 5
  end
  
  if (self.speed ~= 0) then
    if (self.speed > 0) then 
      self.speed = self.speed - 0.5
    end
    if (self.speed < 0) then 
      self.speed = self.speed + 0.5
    end
  end
  
end

function Ship:draw()
  local xx = self.position.x
  local ox = self.origin.x
  local yy = self.position.y
  local oy = self.origin.y
  local sx = self.scale.x
  local sy = self.scale.y
  local rr = self.rot
  love.graphics.draw(self.image,xx,yy,rr,sx,sy,ox,oy,0,0)
end

function Ship:keyPressed(key)
  if key == "space" then
    
  end  
  if (key == "a") then
    self.rotateLeft = true
  end
  
  if (key == "d") then
    self.rotateRight = true
  end
    
  if (key == "w") then
    self.accelerate = true
  end
  
  if (key == "s") then
    self.deAccelerate = true
  end
    
end

function Ship:keyUp(key)
  
  if (key == "a") then
    self.rotateLeft = false
  end
  
  if (key == "d") then
    self.rotateRight = false
  end
  
  if (key == "w") then
    self.accelerate = false
  end
  
  if (key == "s") then
    self.deAccelerate = false
  end
  
end


return Ship