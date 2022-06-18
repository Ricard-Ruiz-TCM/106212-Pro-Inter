--Engine
local AnimatedActor = AnimatedActor or require "src/engine/AnimatedActor"
local Entity = Entity or require "src/engine/Entity"
--Lib
local Vector = Vector or require "lib/vector"

-- Singleton
Audio = Audio or require "src/engine/Audio"
Video = Video or require "src/engine/Video"

-- DATA
DATA = DATA or require "data"

--Class
local Player = AnimatedActor:extend()

local time = 0

function Player:new()
  Player.super.new(self, Video:width() / 2, 0, "player/player", DATA.player.speed, 2, 4, 0.15, true) 
  self.scale = Vector.new(0.2, 0.2)
  self.origin = Vector.new(self.width / 2 * self.scale.x, self.height / 2 * self.scale.y)
  self.position.y = Video:height() - self.height * self.scale.y - 50
  
  -- Ajuste inicial de la collisiones
  self.cBox = {x = x, y = y, w = self.width * self.scale.x, h = self.height * self.scale.y}
  self.cBox.w = self.cBox.w / 2
  self.cBox.h = self.cBox.h / 1.8
  
  --Movimiento
  self.up = false
  self.down = false
  self.left = false
  self.right = false
  
  --Effects 
  self.efecto = false
  
  self.tunnel_effect = Entity(0, 0)
  self.tunnel_effect:setTexture("tunnel")
  self.tunnel_effect.color.a = 0
  
  self:setAnimation(2)
  
end

function Player:update(dt)
  Player.super.update(self,dt)
  --self.position.y = self.position.y + self.speed * dt
  
  -- Ajuste de la collision Box
  self.cBox.x = self.cBox.x + 78
  self.cBox.y = self.cBox.y + 65
  
  self.tunnel_effect.position.x = self.position.x + self.origin.x
  self.tunnel_effect.position.y = self.position.y + self.origin.y
  
  --Mover al player
  if (self.left == true and self.position.x > -10) then
    self.position.x = self.position.x - self.speed*dt
  end
  if (self.right == true and self.position.x + self.width * self.scale.x - 25 < Video:width()) then
    self.position.x = self.position.x + self.speed*dt
  end
  if (self.up == true and self.position.y > 0) then
    self.position.y = self.position.y - self.speed*dt
  end
  if (self.down == true and self.position.y + self.height * self.scale.y - 25 < Video:height()) then
    self.position.y = self.position.y + self.speed*dt
  end
  
  --Effects
  if (self.efecto == true) then
    
    time = time + dt
    
    if (self.beer == true) then
      self.shearing = Vector.new(math.cos(self.time_alive * 2) - 0.5, 0)
    end
    
    if (self.wings == true) then
      self.speed = 400
    end
    
    if (self.immunity == true) then
      self.stunned = false
      self.beer = false
      self.tunnel = false
      self.tunnel_effect.color.a = 0
      self.shearing = Vector.new(0,0)
    end
    
    if (self.tunnel == true) then
      self.tunnel_effect.color.a = 1
    end
    
    if (self.stunned == true) then
      self.speed = 0
      self.color.a = math.sin(self.time_alive % 1)
    end
  
    if (time > 5) then
      self.efecto = false
      self.tunnel_effect.color.a = 0
      self.immunity = false
      self.beer = false
      self.tunnel = false
      self.stunned = false
      self.wings = false
      self:setAnimation(2)
      self.shearing = Vector.new(0,0)
      self.speed = DATA.global.base_speed
      self.color.a = 1
      time = 0
    end
    
  end
  
  DATA.global.speed = self.speed
  
end

function Player:draw()
  Player.super.draw(self)
end


function Player:keyPressed(key) 
  Player.super.keyPressed(self,key)
  
  if (key == "a") then
    self.left = true
  end
  if (key == "d") then 
    self.right = true
  end
  if(key == "w") then
    self.up = true
  end
  if(key == "s") then
    self.down = true
  end
  
  
end

function Player:keyReleased(key)
  Player.super.keyReleased(self,key)
  
  if (key == "a") then
    self.left = false
  end
  if (key == "d") then 
    self.right = false
  end
  if(key == "w") then
    self.up = false
  end
  if(key == "s") then
    self.down = false
  end
  
  end

function Player:applyEffect(effect)
  
  if (not self.efecto or self.beer == true or not self.immunity or effect == "tunnel" or effect == "wings") then
    self.efecto = true
    if (effect == "beer") then 
      Audio:play("fx/beer")
      self.beer = true end
    if (effect == "wings") then 
      self:setAnimation(1)
      Audio:play("fx/wings")
      self.wings = true end
    if (effect == "immunity") then 
      Audio:play("fx/rune")
      self.immunity = true end
    if (effect == "tunnel") then 
      Audio:play("fx/rune")
      self.tunnel = true end
    if (effect == "sword" or effect == "hammer" or effect == "lightning") then 
      if (effect == "sword") then Audio:play("fx/sword") end
      if (effect == "hammer") then Audio:play("fx/hammer") end
      if (effect == "lightning") then Audio:play("fx/thunder") end
      self.stunned = true end
  end
  
end

return Player