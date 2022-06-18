-----------------------------------------------------------------
-- ///////////////////////////////////////////////////// DIRECTOR
-----------------------------------------------------------------

-- Libs
local Object = Object or require "lib/classic"

-- Singleton
Video = Video or require "src/engine/Video"

-- Engine
local UIText = UIText or require "src/engine/UI/UIText"

-- Singleton Class
Director = Object:extend()
--------------------------

--[[ Constructor ]]
function Director:new()
  self.scenes = {}
  self.scene_id = {}
  self.current_scene = 1
  self.scene = 0
  self.frames = 0
  self.time = 0
  self.fps = 0
  if (__DEBUG__) then self.fps_text = UIText(0, 9, "", "left", 18) end
end

--[[ Update
  @param dt -> Delta Time de cada frame
--]]
function Director:update(dt)
  self.time = self.time + dt
  self.frames = self.frames + 1
  self.fps = self.frames/self.time
  self.scenes[self.current_scene]:update(dt)
  if (__DEBUG__) then self.fps_text:setText(string.format("%.0f", tostring(self.fps))) end
end

--[[ Render ]]
function Director:draw()
  Video:clear()
  self.scenes[self.current_scene]:draw()
  if (__DEBUG__) then self.fps_text:draw() end
end

--[[ Input Key Pressed
  @param key -> String de la tecla pulasda
--]]
function Director:keyPressed(key) 
  self.scenes[self.current_scene]:keyPressed(key)
end

--[[ Input Key Released
  @param key -> String de la tecla pulasda
--]]
function Director:keyReleased(key) 
  self.scenes[self.current_scene]:keyReleased(key)
end

--[[ Input Mouse Pressed
  @param x       -> Cordenada X del ratón
  @param y       -> Cordenada Y del ratón
  @param button  -> String del botton pulsado
  @param istouch -> Toques de pantalla
  @param presses -> Cantidad de clicks pulsados rápidamente
--]]
function Director:mousePressed(x, y, button, istouch, presses)
  self.scenes[self.current_scene]:mousePressed(x, y, button, istouch, presses)
end

--[[ Input Mouse Moved
  @param x      -> Cordenada X del ratón
  @param y      -> Cordenada Y del ratón
  @param dx     -> Delta X del ratón
  @param dy     -> Delta Y del rataón
  @para istouch -> Toques de pantalla
--]]
function Director:mouseMoved(x, y, dx, dy, istouch)
  self.scenes[self.current_scene]:mouseMoved(x, y, dx, dy, istouch)
end

--[[ Add Scene
  @param scene -> Escena nueva
--]]
function Director:addScene(scene)
  table.insert(self.scenes, scene)
  scene.ID = #self.scenes
  self.scene_id[scene.name] = scene.ID
end

--[[ Change Scene
  @param id -> Identificador de la escena
--]]
function Director:changeScene(name)
  if (self.scenes[self.current_scene]:wasLoaded()) then self.scenes[self.current_scene]:onExit() end
  self.current_scene = self.scene_id[name]
  self.scenes[self.current_scene]:onEnter()
end

--[[ Cerramos el juego? 
  @return -> (true -> cerramos | false -> no cerramos)
--]]
function Director:isExitTime()
    return (self.scenes[self.current_scene]:isExitTime())
end


return Director

-----------------------------------------------------------------