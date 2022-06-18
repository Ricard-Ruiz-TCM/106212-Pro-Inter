
-- Defines -----
__DEBUG__ = false
----------------

-- Singletons --------------------------------------
Audio = Audio or require "src/engine/Audio"
Video = Video or require "src/engine/Video"
Director = Director or require "src/engine/Director"
----------------------------------------------------
Audio:new(); Video:new(); Director:new()
----------------------------------------------------

-- Scenes -----------------------------------------------------------
local SI = SceneIntro or require "src/scenes/SceneIntro"   -- ID -> 1
local SG = SceneGame or require "src/scenes/SceneGame"     -- ID -> 2
local SO = SceneOver or require "src/scenes/SceneOver"     -- ID -> 3
---------------------------------------------------------------------
SI:new("intro"); SG:new("game"); SO:new("over")
---------------------------------------------------------------------

--[[ Love "Constructor" ]]
function love.load()
  
  -- Enable the debugging with ZeroBrane Studio
  if arg[#arg] == "-debug" then require("mobdebug").start() end 

  -- Añadimos todas las escenas al director
  Director:addScene(SI)
  Director:addScene(SG)
  Director:addScene(SO)
  
  -- Cargamos los audios
  Audio:loadAudio("fx/sword")
  Audio:loadAudio("fx/wings")
  Audio:loadAudio("fx/beer")
  Audio:loadAudio("fx/hammer")
  Audio:loadAudio("fx/rune")
  Audio:loadAudio("fx/thunder")

  -- Cargamos la primera escena
  Director:changeScene("intro")

end

--[[ Love Update ]]
function love.update(dt)

  Director:update(dt)
  if (Director:isExitTime()) then love.event.quit(0) end
  
end

--[[ Love Render ]]
function love.draw()
  
  Director:draw()

end

--[[ Love Input Key Pressed ]]
function love.keypressed(key)

  if (__DEBUG__) then if (key == "escape") then love.event.quit(0) end end
  
  Director:keyPressed(key)

end

--[[ Love Input Key Released ]]
function love.keyreleased(key)
  
  Director:keyReleased(key)

end

--[[ Love Input Mouse Pressed ]]
function love.mousepressed(x, y, button, istouch, presses)

  Director:mousePressed(x, y, button, istouch, presses)

end

--[[ Love Input Mouse Moved]]
function love.mousemoved(x, y, dx, dy, istouch)

  Director:mouseMoved(x, y, dx, dy, istouch)

end