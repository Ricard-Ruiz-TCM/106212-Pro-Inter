-----------------------------------------------------------------
-- //////////////////////////////////////////////////////// VIDEO
-----------------------------------------------------------------

-- Libs
local Object = Object or require "lib/classic"

-- Singleton Class
Video = Object:extend()
-----------------------

--[[ Constructor ]]--
function Video:new()
  self.textures = {}
  self.background_color = {0.5, 0.5, 0.5, 1}
  self.w, self.h = love.graphics.getDimensions()
end

--[[ Set
  @param name -> Futuro identificador de la textura y dirección
  @return     -> Objeta de textura
--]]
function Video:loadTexture(name)
  if (not self:exists(name)) then self.textures[name] = love.graphics.newImage("assets/textures/" .. name .. ".png") end
  return self:texture(name)
end

--[[ Get
  @param name -> Identificador de la textura
  @return     -> Objeto de textura
--]]
function Video:texture(name)
  return self.textures[name]
end

--[[ Existe?
  @param name -> Identificador de la textura
  @return     -> (true -> Existe | false -> No existe)
--]]
function Video:exists(name)
  return (self.textures[name] ~= nil)
end

--[[ Set Color
  @param color -> Tabla con los colores
--]]
function Video:setColor(color)
  love.graphics.setColor(color.r or 1, color.g or 1, color.b or 1, color.a or 1)
end

--[[ Render
  @param name     -> Identificador de la textura
  @param quad     -> Rect de cordenadas, ancho y alto de la textura
  @param position -> Posición en la pantalla
  @param rotation -> Rotación de la textura
  @param scale    -> Escala de la textura 
  @param origin   -> Offset x y y de la textura
  @param shearing -> Offset de pintado
--]]
function Video:draw(name, quad, position, rotation, scale, origin, shearing)
  if (self:exists(name)) then love.graphics.draw(self:texture(name), quad, position.x, position.y, rotation, scale.x, scale.y, origin.x, origin.y, shearing.x, shearing.y) end
end

--[[ Screen Width
  @return ancho de la pantalla
--]]
function Video:width()
  return self.w
end

--[[ Screen Height
  @return alto de la pantalla
--]]
function Video:height()
  return self.h
end

--[[ Clear Screen ]]
function Video:clear()
  love.graphics.clear(self.background_color)
end

return Video

-----------------------------------------------------------------