-----------------------------------------------------------------
-- ///////////////////////////////////////////////////// UIButton
-----------------------------------------------------------------

-- Libs
local Vector = Vector or require "lib/vector"

-- Engine
local Entity = Entity or require "src/engine/Entity"
local UIText = UIText or require "src/engine/UI/UIText"

-- Locals
local UIButton = Entity:extend()

--[[ Constructor
  @param x -> Posición X de la pantalla
  @param y -> Posición Y de la pantalla
  @param texture -> Texutra del boton
  @param 
--]]
function UIButton:new(x, y, texture, method, text)
  -- Super ---------------------
  UIButton.super.new(self, x, y)
  ------------------------------
  self:setTexture(texture or "ui/button")
  self.onClick = method or (function() end)
  self.txt = text or UIText()
  self.txt:move(self.position.x, self.position.y)
end

--[[ Render ]]
function UIButton:draw()
  -- Super ----------------
  UIButton.super.draw(self)
  -------------------------
  self.txt:draw()
end

--[[ Reload ]]
function UIButton:reload()
  -- Super ------------------
  UIButton.super.reload(self)
  ---------------------------
  self.text:reload()
end

--[[ Texto
  @return -> Texto del boton
--]]
function UIButton:text()
  return self.txt
end

--[[ Move
  @param x -> Cordenada X
  @param y -> Cordenada Y
--]]
function UIButton:move(x, y)
  self.position = Vector.new(x, y)
  self.txt:move(x, y)
  self:checkHover(love.mouse.getX(), love.mouse.getY())
end

--[[ Checka Hover Effect
  @param x -> Cordenada X
  @param y -> Cordenada Y
--]]
function UIButton:checkHover(x, y)
  if (self:intersect(x + self.origin.x, y + self.origin.y, 1, 1)) then
    self.color.a = 0.5 
  else 
    self.color.a = 1 
  end
end

--[[ Set Method
  @method -> Añade el método al botón
--]]
function UIButton:setMethod(method)
  self.onClick = method
end

--[[ Input Mouse Pressed
  @param x       -> Cordenada X del ratón
  @param y       -> Cordenada Y del ratón
  @param button  -> String del botton pulsado
  @param istouch -> Toques de pantalla
  @param presses -> Cantidad de clicks pulsados rápidamente
--]]
function UIButton:mousePressed(x, y, button, istouch, presses)
  -- Super --------------------------------------------------------
  UIButton.super.mousePressed(self, x, y, button, istouch, presses)
  -----------------------------------------------------------------
  if (button == 1) then if (self:intersect(x + self.origin.x, y + self.origin.y, 1, 1)) then self:onClick() end end
end

--[[ Input Mouse Moved
  @param x      -> Cordenada X del ratón
  @param y      -> Cordenada Y del ratón
  @param dx     -> Delta X del ratón
  @param dy     -> Delta Y del rataón
  @para istouch -> Toques de pantalla
--]]
function UIButton:mouseMoved(x, y, dx, dy, istouch)
  -- Super ---------------------------------------------
  UIButton.super.mouseMoved(self, x, y, dx, dy, istouch)
  ------------------------------------------------------
  self:checkHover(x, y)
end

return UIButton

-----------------------------------------------------------------