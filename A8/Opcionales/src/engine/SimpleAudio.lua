-----------------------------------------------------------------
-- ////////////////////////////////////////////////// SimpleAudio
-----------------------------------------------------------------

-- Libs
local Object = Object or require "lib/classic"

-- Class
local SimpleAudio = Object:extend()
-----------------------------------

function SimpleAudio:new()
end

function SimpleAudio:loadSingleton()
  self.audios = {}
end

function SimpleAudio:playAudio(name,volume)
  if (self:exist(name) == false) then
    self:loadAudio(name,"static")
  end
  self.audios[name]:setVolume(volume or 1)
  self.audios[name]:play()
 
end
function SimpleAudio:exist(name)
  return (self.audios[name] ~= nil)
end

function SimpleAudio:loadAudio(name, mode)
  self.audios[name] = love.audio.newSource("assets/sounds/" .. name .. ".wav", mode)
end

return SimpleAudio

-----------------------------------------------------------------