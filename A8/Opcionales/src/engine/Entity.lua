-----------------------------------------------------------------
-- /////////////////////////////////////////////////////// ENTITY
-----------------------------------------------------------------

-- Libs
local Object = Object or require "lib/classic"
local Vector = Vector or require "lib/vector"

-- Class
local Entity = Object:extend()
------------------------------

function Entity:new(x, y, rotation, texture)
  self.position = Vector.new(x or 0, y or 0)
  self.base_position = Vector.new(x or 0, y or 0)
  self.scale = Vector.new(1, 1)
  self.rotation = rotation or 0
  self.base_rotation = rotation or 0
  self:setTexture(texture)
end

function Entity:update(dt)
end

function Entity:draw()
  love.graphics.setColor(1, 1, 1, 1)
  love.graphics.draw(self.texture, self.position.x, self.position.y, self.rotation, self.scale.x, self.scale.y)
end

function Entity:reload()
  self.position = Vector.new(self.base_position.x, self.base_position.y)
  self.scale = Vector.new(1, 1)
  self.rotation = self.base_rotation
end

function Entity:setTexture(path)
  self.texture = love.graphics.newImage(image or path)
  self.w = self.texture:getWidth() or 0
  self.h = self.texture:getHeight() or 0
  self.origin = Vector.new(self.w / 2, self.h / 2)
end

function Entity:intersect(x, y, w, h)
  return (((self.position.x + self.w) > x) and (self.position.x < (x + w)) and ((self.position.y + self.h) > y) and (self.position.y < (y + h)))
end

function Entity:intersectEntity(entity)
  return (self:intersect(entity.position.x, entity.position.y, entity.w, entity.h))
end

function Entity:keyPressed(key)
end

function Entity:keyReleased(key)
end

return Entity

-----------------------------------------------------------------