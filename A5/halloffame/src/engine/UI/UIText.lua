-----------------------------------------------------------------
-- /////////////////////////////////////////////////////// UIText
-----------------------------------------------------------------

-- Libs
local Vector = Vector or require "lib/vector"

-- Engine
local Entity = Entity or require "src/engine/Entity"

-- Class
local UIText = Entity:extend()
------------------------------

--[[ Constructor
  @param x     -> Posición X de la pantalla
  @param y     -> Posición Y de la pantalla
  @param text  -> Texto
  @param align -> Alineación del texto
  @param size  -> Tamaño del texto
  @param font  -> Fuente que utilizará el texto
  @param color -> Tabla {r, g, b, a} con información del color
--]]
function UIText:new(x, y, text, align, size, font, color)
  if (type(x) == "string") then text = x; x = 0 end
  -- Super -------------------
  UIText.super.new(self, x, y)
  ----------------------------
  self.fixed_position = Vector.new(self.position.x, self.position.y)
  self.text = text or ""
  self.align = align or "center"
  self.size = size or 12
  if (font) then 
    self.custom = font
    self.font = love.graphics.newFont(font, self.size)
  else self.font = love.graphics.newFont(self.size) end
  self.color = color or {r = 1, g = 1, b = 1, a = 1}
  self:fixPosition()
end

--[[ Draw ]]
function UIText:draw()
  love.graphics.setFont(self.font)
  love.graphics.setColor(self.color.r, self.color.g, self.color.b, self.color.a)
  love.graphics.print(self.text, self.font, self.fixed_position.x, self.fixed_position.y, self.rotation, self.scale.x, self.scale.y, self.origin.x, self.origin.y)
end

--[[ Move
  @param x -> Cordenada X
  @param y -> Cordenada Y
--]]
function UIText:move(x, y)
  self.position = Vector.new(x, y)
  self:fixPosition()
end

--[[ Set Align
  @param align -> Eje de fijación
--]]
function UIText:setAlign(align)
  self.align = align or "left"
  self:fixPosition()
end

--[[ Set Text
  @param text -> Nuevo texto
--]]
function UIText:setText(text)
  self.text = text or ""
  self:fixPosition()
end

--[[ Set Font
  @param path -> Fuente nueva
  @param pt   -> Tamaño de la fuente
--]]
function UIText:setFont(path, pt)
  self.custom = path
  self.size = pt or self.size
  self:setTextSize()
end

--[[ Set Color
  @param r -> Rojo
  @param g -> Verde
  @param b -> Azul
  @param a -> Alpha
--]]
function UIText:setColor(r, g, b, a)
  self.color = {r = r or self.color.r, g = g or self.color.g, b = b or self.color.b, a = a or self.color.a}
end

--[[ Set Text Size
  @param pt -> Nuevo tamaño del texto
--]]
function UIText:setTextSize(pt)
  if (self.custom) then self.font = love.graphics.newFont(self.custom, pt or self.size)
  else self.font = love.graphics.newFont(pt or self.size) end
  self:fixPosition()
end

--[[ Fix Position ]]
function UIText:fixPosition()
   
  local w = self.font:getWidth(self.text) / 2
  local h = self.font:getHeight(self.text) / 2
  
  if (self.align == "left") then
    self.fixed_position.x = self.position.x
  elseif (self.align == "center") then
    self.fixed_position.x = self.position.x - w
  elseif (self.align == "right") then
    self.fixed_position.x = self.position.x - (w * 2)
  end

  self.fixed_position.y = self.position.y - h
  
  self.width = self.font:getWidth(self.text)
  self.height = self.font:getHeight(self.text)
  
end

return UIText

-----------------------------------------------------------------