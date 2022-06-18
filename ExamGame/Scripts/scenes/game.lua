
local sti = sti or require "Scripts/sti"
local Ship = Ship or require "Scripts/Ship"
local Animal = Animal or require "Scripts/Animal"
local Actor = Actor or require "Scripts/Actor"

local Timer = Timer or require "Scripts/Timer"

local Object = Object or require "Scripts/object"

local Game = Object:extend()


function Game:new()
  
  self.actorList = {}
  self.offSet = 0
  
  self.map = sti("Scripts/MapaPirate.lua", {"box2d"})
  love.physics.setMeter(32)
  self.world = love.physics.newWorld(0,0)
  self.map:box2d_init(self.world)

  table.insert(self.actorList, Ship())
  
  self.player_id = #self.actorList
  
  -- Creamos timer pra que aparezca un animal entre 3 y 6 segundos
  table.insert(self.actorList, Timer(math.random(30, 60) / 10, function() self:spawnAnimal() end, true))
  
end

function Game:update(dt)
  
    self.world:update(dt)
    self.map:update(dt)
    for i=1,#self.actorList,1 do
      v = self.actorList[i]
      v:update(dt)
      -- Borramos de la lista los animales que no están "alive"
      if (v:is(Animal)) then
        if (not v.alive) then table.remove(self.actorList, i); i = i - 1 end
      end
    end
    -- Comprobamos colisiones
    self:checkCol()
    self.offSet = self.offSet - dt * 10
    
end

function Game:draw()
  
  self.map:draw(self.offSet, 0)
  
  love.graphics.translate(0, 0)
  for _,v in ipairs(self.actorList) do
    v:draw()
  end
  
end

function Game:checkCol()
  
  for i=1,#self.actorList,1 do
    v = self.actorList[i]
    if (v:is(Animal)) then
      -- Si el animal colisiona y no ha sido rescatado ya, lo rescatamos y añadimos a los rescatados del Ship
      if (Actor.intersect(self.actorList[self.player_id], v) and not v.rescued_by_ship) then
        v:rescued()
        self.actorList[self.player_id]:rescued(v)
      end
    end
  end
  
end

function Game:spawnAnimal()
  -- Los animales permaneceran "alive" durante 30s - 50% en segundos del total rescatados (4 rescatados = -2s)
  table.insert(self.actorList, Animal(30 - (self.actorList[self.player_id].total_rescued * 0.5)))
end

function Game:keyreleased(key)
  self.actorList[self.player_id]:keyreleased(key)
end

return Game