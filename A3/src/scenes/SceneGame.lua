
-- Engine
local Scene = Scene or require "src/engine/Scene"
local Timer = Timer or require "src/engine/Timer"
local Entity = Entity or require "src/engine/Entity"

-- Objects
local HUD = HUD or require "src/HUD"
local Ship = Ship or require "src/objects/Ship"
local Bullet = Bullet or require "src/objects/Bullet"
local Asteroid = Asteroid or require "src/objects/Asteroid"
local Explosion = Explosion or require "src/objects/Explosion"

-- Locals
local w, h = love.graphics.getDimensions()

local ship_id = -1
local hud_id = -1

-- Class
local SceneGame = Scene:extend()
---------------------------------

function SceneGame:new()
  SceneGame.super.new(self)
  --------------------------
  self:addEntity(Entity(w / 2, h / 2, "assets/textures/background.jpg"))
  self:addEntity(Timer(1, (function() self:asteroidSpawn() end), true))
  ship_id = self:addEntity(Ship(w / 2, h / 2, function() self:bulletSpawn() end))
  hud_id = self:addEntity(HUD())
end

function SceneGame:update(dt)
  SceneGame.super.update(self, dt)
  --------------------------------  
  self:checkCollisions()
  self:getEntity(hud_id):updateHUD(self:getEntity(ship_id))
end

function SceneGame:reload()
  SceneGame.super.reload(self)
  ----------------------------
  for i,v in ipairs(self.entities) do
    if ((v:is(Bullet)) or (v:is(Asteroid) or (v:is(Explosion)))) then
      v:destroy()
    end
  end
end

function SceneGame:checkCollisions()
  for _,a in ipairs(self.entities) do
    if (a:is(Asteroid)) then
      for _,b in ipairs(self.entities) do
        if (b:is(Bullet)) then 
          if (a:checkCollision(b)) then self:colAB(a, b, self:getEntity(ship_id)) end 
        end
      end
      if (a:checkCollision(self:getEntity(ship_id))) then self:colAS(a, self:getEntity(ship_id)) end
    end
  end
end

-- Resuelve la colision entre asteroide y bala, | Destruye asteroide; Destruye Bala; Genera explosión; Suma puntos al jugador
function SceneGame:colAB(a, b, s)
  a:destroy(); b:destroy(); self:explosionSpawn(a.position); s:increaseScore()
end

-- Resuelve la colision entre asteroide y nave | Destruye asteroide; Comprueba si puede dar al jugador; Pasa de escena si no tiene vida; Resulve colision AsteroideJugador
function SceneGame:colAS(a, s)
  a:destroy(); if (s:canHit()) then if (s:isDone()) then GSM:changeState("splash") else s:colAsteroid() end end
end

function SceneGame:asteroidSpawn()
  self:addEntity(Asteroid())
end

function SceneGame:bulletSpawn()
  self:addEntity(Bullet(self:getEntity(ship_id).position.x, self:getEntity(ship_id).position.y, self:getEntity(ship_id).rotation))
end

function SceneGame:explosionSpawn(pos)
  self:addEntity(Explosion(pos.x, pos.y))
end

return SceneGame
