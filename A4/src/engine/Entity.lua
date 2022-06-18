-----------------------------------------------------------------
-- /////////////////////////////////////////////////////// ENTITY
-----------------------------------------------------------------

-- Libs
local Object = Object or require "lib/classic"
local Vector = Vector or require "lib/vector"

-- Singletons
Video = Video or require "src/engine/Video"

-- Class
local Entity = Object:extend()
------------------------------

--[[ Constructor
  @param x -> Posición X de la pantalla
  @param y -> Posición Y de la pantalla
--]]
function Entity:new(x, y)
  self.alive = true
  self.time_alive = 0
  self.position = Vector.new(x or 0, y or 0)
  self.base_position = Vector.new(self.position.x, self.position.y)
  self:setSize(1, 1)
  self.scale = Vector.new(1, 1)
  self.shearing = Vector.new(0, 0)
  self.rotation = 0
  self.color = {r = 1, g = 1, b = 1, a = 1}
  self.cBox = {x = x, y = y, w = self.width, h = self.height}
end

--[[ Update
  @param dt -> Delta Time de cada frame
--]]
function Entity:update(dt)
  -- Updte del tiempo de vida del objeto
  self.time_alive = self.time_alive + dt
  
  -- Update de la collision Box
  self.cBox.x = self.position.x - self.origin.x
  self.cBox.y = self.position.y - self.origin.y
end

--[[ Render ]]
function Entity:draw()
  Video:setColor(self.color)
  Video:draw(self.texture_id, self.quad, self.position, self.rotation, self.scale, self.origin, self.shearing)
  if (__DEBUG__) then
    love.graphics.setColor(1, 0, 0, 1)
    love.graphics.rectangle("line", self.cBox.x, self.cBox.y, self.cBox.w, self.cBox.h)
  end
end

--[[ Reload ]]
function Entity:reload()
  self.position = Vector.new(self.base_position.x, self.base_position.y)
  self.scale = Vector.new(1, 1)
  self.shearing = Vector.new(1, 1)
  self.rotation = 0
end

--[[ Input Key Pressed
  @param key -> String de la tecla pulasda
--]]
function Entity:keyPressed(key) end

--[[ Input Key Released
  @param key -> String de la tecla pulasda
--]]
function Entity:keyReleased(key) end

--[[ Input Mouse Pressed
  @param x       -> Cordenada X del ratón
  @param y       -> Cordenada Y del ratón
  @param button  -> String del botton pulsado
  @param istouch -> Toques de pantalla
  @param presses -> Cantidad de clicks pulsados rápidamente
--]]
function Entity:mousePressed(x, y, button, istouch, presses)
end

--[[ Input Mouse Moved
  @param x      -> Cordenada X del ratón
  @param y      -> Cordenada Y del ratón
  @param dx     -> Delta X del ratón
  @param dy     -> Delta Y del rataón
  @para istouch -> Toques de pantalla
--]]
function Entity:mouseMoved(x, y, dx, dy, istouch)
end

--[[ Set Texture
  @param path -> Identificador de la textura y dirección
  @param x    -> Cordenada X de la textura
  @param y    -> Cordenada Y de la textura
  @param w    -> Ancho de la textura
  @param h    -> Alto de la textura
--]]
function Entity:setTexture(path, x, y, w, h)
  self.texture = Video:loadTexture(path)
  self.texture_id = path
  self.quad = love.graphics.newQuad(x or 0, y or 0, w or self.texture:getWidth(), h or self.texture:getHeight(), self.texture:getWidth(), self.texture:getHeight())
  self:setSize(w or self.texture:getWidth(), h or self.texture:getHeight())
end

--[[ Set Size
  @param w -> Ancho
  @param h -> Alto
--]]
function Entity:setSize(w, h)
  self.width = w or 1
  self.height = h or 1
  self.origin = Vector.new(self.width / 2, self.height / 2)
end

--[[ Rect Intersect 
  @param x -> Posición x
  @param y -> Posición y
  @param w -> Ancho
  @param h -> Alto
  @return  -> (true -> collisión | false -> sin colisión)
--]]
function Entity:intersect(x, y, w, h)
  return (((self.cBox.x + self.cBox.w) > x) and (self.cBox.x < (x + w)) and ((self.cBox.y + self.cBox.h) > y) and (self.cBox.y < (y + h)))
end

--[[ Check Collision con Entidades
  @param entity -> Entidad cuadrada
  @return  -> (true -> collisión | false -> sin colisión)
--]]
function Entity:checkCollision(entity)
  return (self:intersect(entity.position.x, entity.position.y, entity.width, entity.height))
end

--[[ Estoy vivo?
  @return -> (true -> vivo | false -> muerto)
--]]
function Entity:isAlive()
  return self.alive
end

--[[ Estoy muerto?
  @return -> (true -> muerto | false -> vivo)
--]]
function Entity:isDeath()
  return (not self.alive)
end

--[[ Destroy ]]
function Entity:destroy()
  self.alive = false
end

return Entity

-----------------------------------------------------------------