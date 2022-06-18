-----------------------------------------------------------------
-- //////////////////////////////////////////////////////// AUDIO
-----------------------------------------------------------------

-- Libs
local Object = Object or require "lib/classic"

-- Singleton Class
Audio = Object:extend()
-----------------------

--[[ Constructor ]]
function Audio:new()
  self.audios = {}
end

--[[ Set
  @param name      -> Futuro identificador del audio y dirección
  @param extension -> Extensión del audio
  @param mode      -> Modo de carga "static" o "stream"
  @return          -> Objeto de audio
--]]
function Audio:loadAudio(name, extension, mode)
  if (not self:exist(name)) then self.audios[name] = love.audio.newSource("assets/audio/" .. name .. (extension or ".wav"), mode or "static") end 
  return self:audio(name)
end

--[[ Get
  @param name -> Identificador del audio
  @return     -> Objeto de audio
--]]
function Audio:audio(name)
  return self.audios[name]
end

--[[ Play
  @param name -> Identificador del audio
--]]
function Audio:play(name)
  if (self:exist(name)) then self.audios[name]:play() end 
end

--[[ Pause
  @param name -> Identificador del audio
--]]
function Audio:pause(name)
  if (self:exist(name)) then self.audios[name]:pause() end
end

--[[ Stop
  @param name -> Identificador del audio
--]]
function Audio:stop(name)
  if (self:exist(name)) then self.audios[name]:stop() end
end

--[[ Existe?
  @param name -> Identificador del audio
  @return     -> (true -> Existe | false -> No existe)
--]]
function Audio:exist(name)
  return (self.audios[name] ~= nil)
end

return Audio

-----------------------------------------------------------------