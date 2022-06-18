local Asteroid = Asteroid or require "Scripts/Asteroid"
local Ship = Ship or require "Scripts/Ship"

local actorList = {}  --Lista de elementos de juego

function love.load()
  local s = Ship:extend()
  s:new()
  table.insert(actorList,s)
end

function love.update(dt)
  for _,v in ipairs(actorList) do
    v:update(dt)
  end
end

function love.draw()
  for _,v in ipairs(actorList) do
    v:draw()
  end
end

function love.keypressed(key)
  if (key == "a") then
    addAsteroid()
  end
  
  for _,v in ipairs(actorList) do
    if v:is(Ship) then
      v:keyPressed(key)
    end
  end
end

function love.keyreleased(key)
  for _,v in ipairs(actorList) do
    if v:is(Ship) then
      v:keyUp(key)
    end
  end
end

function addAsteroid()
  local a = Asteroid:extend()
  a:new()
  table.insert(actorList,a)
end

