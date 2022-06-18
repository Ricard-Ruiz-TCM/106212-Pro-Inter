-----------------------------------------------------------------
-- //////////////////////////////////////////////////////// SCENE
-----------------------------------------------------------------

-- Libs
local Object = Object or require "lib/classic"

-- Engine
local Timer = Timer or require "src/engine/Timer"

-- Class
local Scene = Object:extend()
-----------------------------

--[[ Constructor
  @param name -> Identificador de la escena
--]]
function Scene:new(name)
  self.ID = -1
  self.name = name or "exit"
  self.entities = {}
  self.exit = false
  self.time = 0
  self.load = false
end

--[[ On Enter Virtual Method ]]
function Scene:onEnter()
  self.load = true
end

--[[ Update
  @param dt -> Delta Time entre frames
--]]
function Scene:update(dt)
  self.time = self.time + dt
  for i, v in ipairs(self.entities) do
    if (v.update) then v:update(dt) end
    if (v.isDeath) then if (v:isDeath()) then self:removeEntity(i) end end
  end
end

--[[ On Exit Virtual Method ]]
function Scene:onExit()
  self.load = false
end

--[[ Render ]]
function Scene:draw()
  for _, v in ipairs(self.entities) do
    if (v.draw) then v:draw() end
  end
end

--[[ Reload ]]
function Scene:reload()
  self.exit = false
  self.time = 0
  for _, v in ipairs(self.entities) do
    if (v.reload) then v:reload() end
  end
end

--[[ Input Key Pressed
  @param key -> String de la tecla pulasda
--]]
function Scene:keyPressed(key)
  for _, v in ipairs(self.entities) do
    if (v.keyPressed) then v:keyPressed(key) end
  end
end

--[[ Input Key Released
  @param key -> String de la tecla pulasda
--]]
function Scene:keyReleased(key)
  for _, v in ipairs(self.entities) do
    if (v.keyReleased) then v:keyReleased(key) end
  end
end

--[[ Input Mouse Pressed
  @param x       -> Cordenada X del ratón
  @param y       -> Cordenada Y del ratón
  @param button  -> String del botton pulsado
  @param istouch -> Toques de pantalla
  @param presses -> Cantidad de clicks pulsados rápidamente
--]]
function Scene:mousePressed(x, y, button, istouch, presses)
  for _, v in ipairs(self.entities) do
    if (v.mousePressed) then v:mousePressed(x, y, button, istouch, presses) end
  end
end

--[[ Input Mouse Moved
  @param x      -> Cordenada X del ratón
  @param y      -> Cordenada Y del ratón
  @param dx     -> Delta X del ratón
  @param dy     -> Delta Y del rataón
  @para istouch -> Toques de pantalla
--]]
function Scene:mouseMoved(x, y, dx, dy, istouch)
  for _, v in ipairs(self.entities) do
    if (v.mouseMoved) then v:mouseMoved(x, y, dx, dy, istouch) end
  end
end

--[[ Add Entity
  @param entity -> Entidad a añadir a la escena
--]]
function Scene:addEntity(entity)
  table.insert(self.entities, entity)
  return #self.entities
end

--[[ Get Entity
  @param id -> Identificador de la entidad
  @return   -> Entidad
--]]
function Scene:getEntity(id)
  return self.entities[id]
end

--[[ Find Entity
  @param object -> Objecto a buscar
  @return       -> La primera isntancia de ese objecto
--]]
function Scene:findEntity(object)
  for i,v in ipairs(self.entities) do
    if (v:is(object)) then
      return v
    end
  end
  return nil
end

--[[ Remove All Entities ]]
function Scene:removeAllEntities()
  while(#self.entities > 0) do
    table.remove(self.entities, #self.entities)
  end
end

--[[ Remove Entity
  @param id -> Identificador de la entidad
--]]
function Scene:removeEntity(id)
  table.remove(self.entities, id)
end

--[[ Control de Exit del jeugo ]]
function Scene:exitNow()
  self.exit = true
end

--[[ Cerramos el juego? 
  @return -> (true -> cerramos | false -> no cerramos)
--]]
function Scene:isExitTime()
  return self.exit
end

--[[ Cargamos la escena? (Entro en el método onEnter)
  @return -> (true -> cargada | false -> no cargada)
--]]
function Scene:wasLoaded()
  return self.load
end

return Scene

-----------------------------------------------------------------