-----------------------------------------------------------------
-- //////////////////////////////////////////////////////// SCENE
-----------------------------------------------------------------

-- Libs
local Object = Object or require "lib/classic"

-- Class
local Scene = Object:extend()
-----------------------------

function Scene:new()
  self.entities = {}
  self.exit = false
  self.next = false
  self.time = 0
end

function Scene:update(dt)
  self.time = self.time + dt
  for _, v in ipairs(self.entities) do
    v:update(dt)
  end
end

function Scene:draw()
  for _, v in ipairs(self.entities) do
    v:draw()
  end
end

function Scene:reload()
  self.exit = false
  self.next = false
  self.time = 0
  for _, v in ipairs(self.entities) do
    v:reload()
  end
end

function Scene:addEntity(entity)
  table.insert(self.entities, entity)
  return #self.entities
end

function Scene:getEntity(id)
  return self.entities[id]
end

function Scene:exitNow()
  self.exit = true
end

function Scene:isExitTime()
  return self.exit
end

function Scene:nextScene()
  self.next = true
end

function Scene:moveToNextScene()
  return self.next
end

function Scene:getNextSceneID()
  return self.nextSceneID
end

function Scene:setNextSceneID(id)
  self.nextSceneID = id
end

function Scene:keyPressed(key)
end

function Scene:keyReleased(key)
end

function Scene:mousePressed(x, y, button, istouch, presses)
end

return Scene

-----------------------------------------------------------------