Actor = Actor or require "Scripts/Actor"
local Ship = Actor:extend()
Vector = Vector or require "Scripts/vector"
Bullet = Bullet or require "Scripts/Bullet"

function Ship:new()
  Ship.super.new(self,"Textures/ship.png",150,150,0,1,0)
  self.rSpeed=60
  -- Total de rescatados, para computar con el tiempo que apareceran en la playa
  self.total_rescued = 0
  -- Tabla de animales rescatados para computar su posicion 
  self.table_rescued = {}
  -- Tabla rellena de 0 con la cantidad de animales ya salvados, 
  -- Los animales van desde el tipo 1 al tipo 30, de esta forma cuando salvemos
  -- A un animal del tipo 3, la posicón de esta table segun el tipo de animal se incrementará en 1
  -- De esta forma, cuando rescatemos 3 iguales, se podrá comprobar facilmente
  self.table_rescued_win = {}
  
  -- Rellenamos la tabla de 0
  for i = 1, 30, 1 do
    table.insert(self.table_rescued_win, 0)
  end
  
end

function Ship:update(dt)
  Ship.super.update(self,dt)
  
  if self.speed > 0 then
    self.speed = self.speed-10*dt
  elseif self.speed <0 then
    self.speed = self.speed+10*dt
  end 

  if love.keyboard.isDown("left") then
    ang = math.rad(self.rSpeed)*dt*-1
    self.forward:rotate(ang)
    self.rot=Vector.ang(self.forward)
  end
  if love.keyboard.isDown("right") then
    ang = math.rad(self.rSpeed)*dt
    self.forward:rotate(ang)
    self.rot=Vector.ang(self.forward)
  end
  if love.keyboard.isDown("up") then
    self.speed = self.speed + 100*dt
  end
  if love.keyboard.isDown("down") then
    self.speed = self.speed - 100*dt
  end
  
  -- Update de posición de los animales rescatados
  compy = 0
  compx = 0
  for i,v in ipairs(self.table_rescued) do
    if (i % 10 == 0) then compy = compy + 15; compx = 0; end
    v.position.x = self.position.x + (10 * compx) - 50
    v.position.y = self.position.y + compy - 20
    v.rot = self.rot
    v.forward:rotate(v.rot)
    compx = compx + 1
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

function Ship:keyreleased(key)
  if key=="space" then
    --Bullet
  end
end

function Ship:rescued(animal)
  self.total_rescued = self.total_rescued + 1
  table.insert(self.table_rescued, animal)
  
  -- Computamos el valor de animales rescatados del mismo tipo
  self.table_rescued_win[animal.type] = self.table_rescued_win[animal.type] + 1
  
  -- Si hemos resctadado 3 o más se nos pasa a la siguiente escena de victoria
  if (self.table_rescued_win[animal.type] >= 3) then
    global_current_scene = 3
  end
    
end

return Ship

