-----------------------------------------------------------------
-- /////////////////////////////////////////////// ANIMATED_ACTOR
-----------------------------------------------------------------

-- Libs
local Object = Object or require "lib/classic"
local Vector = Vector or require "lib/vector"

-- Engine
local Actor = Actor or require "src/engine/Actor"
local Timer = Timer or require "src/engine/Timer"

-- Class
local AnimatedActor = Actor:extend()
------------------------------------

--[[ Constructor
  @param x          -> Posición X de la pantalla
  @param y          -> Posición Y de la pantalla
  @param texture    -> Path de la textura
  @param speed      -> Velocidad del actor
  @param animations -> Total de animaciones
  @param frames     -> Total de frames por animacion
  @param framerate  -> Frame Rate
  @param loop       -> Bucle de la animación
--]]
function AnimatedActor:new(x, y, texture, speed, animations, frames, framerate, loop)
  -- Entity Super -------------------------
  AnimatedActor.super.super.new(self, x, y)
  -- Actor Manual Super -------------------
  self:setTexture(texture)
  self.speed = speed or 0
  self.base_speed = self.speed
  -----------------------------------------
  self.frame = 1
  self.total_frames = frames or self.frame
  self.animation = 1
  self.total_animations = animations or self.animation
  self.animation_frames = {}
  self.frame_rate = framerate or 1
  self.animation_time = 0
  self.loop = loop or false
  self.animation_finished = false
  self:loadAnimation(texture, animations, frames)
end

--[[ Update
  @param dt -> Delta Time de cada frame
--]]
function AnimatedActor:update(dt)
  -- Super ---------------------------
  AnimatedActor.super.update(self, dt)
  ------------------------------------
  self.animation_time = self.animation_time + dt
  if (self.animation_time >= self.frame_rate) then
    self.animation_time = 0
    self.frame = self.frame + 1
    if (self.frame > self.total_frames) then
      if (self.loop) then
        self.frame = 1
      else
        self.frame = self.frame - 1
        self.animation_finished = true
      end
    end
  end
end

--[[ Render ]]
function AnimatedActor:draw()
  love.graphics.setColor(self.color.r, self.color.g, self.color.b, self.color.a)
  love.graphics.draw(self.texture, self.animation_frames[self.animation][self.frame], self.position.x, self.position.y, self.rotation, self.scale.x, self.scale.y, self.origin.x, self.origin.y, self.shearing.x, self.shearing.y)
  if (__DEBUG__) then
    love.graphics.setColor(1, 0, 0, 1)
    love.graphics.rectangle("line", self.cBox.x, self.cBox.y, self.cBox.w, self.cBox.h)
  end
end

--[[ Reload ]]
function AnimatedActor:reload()
  -- Super -----------------------
  AnimatedActor.super.reload(self)
  --------------------------------
  self:reset()
end

--[[ Reset Anim ]]
function AnimatedActor:reset()
  self.frame = 1
  self.animation = 1
  self.animation_finished = false
end

--[[ Load Animation
  @param animations -> Total de animaciones
  @param frames     -> Total de frames por aniamción
--]]
function AnimatedActor:loadAnimation(animations, frames)
  self:setSize(self.texture:getWidth() / self.total_frames, self.texture:getHeight() / self.total_animations)
  local x = 0
  local y = 0
  for a = 1, self.total_animations, 1 do
    self.animation_frames[a] = {}
    x = 0
    for f = 1, self.total_frames, 1 do
      self.animation_frames[a][f] = love.graphics.newQuad(x, y, self.width, self.height, self.texture:getWidth(), self.texture:getHeight())
      x = x + self.width
    end
    y = y + self.height
  end
end

--[[ Set Animation
  @param id -> ID de la animación
--]]
function AnimatedActor:setAnimation(id)
  if (self.animation ~= id) then
    self.animation = id
    if ((self.animation < 0) or (self.animation > self.total_animations)) then self.aniomation = 1 end
    self.frame = 1
    self.animation_time = 0
  end
end

--[[ Acabo mi animación?
  @return -> (true -> acabada | false -> no acabada)
--]]
function AnimatedActor:animFinished()
  return self.animation_finished
end

return AnimatedActor

-----------------------------------------------------------------