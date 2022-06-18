
-- Lib
local StateMachine = StateMachine or require "lib/statemachine"

-- Scenes
local SS = SceneSplash or require "src/scenes/SceneSplash"   -- ID 1
local SM = SceneMenu or require "src/scenes/SceneMenu"       -- ID 2
local SG = SceneGame or require "src/scenes/SceneGame"       -- ID 3

-- Locals
local w, h = love.graphics.getDimensions()

local mScenes = {}
local mCurrentScene = 1

-- Globals
GSM = StateMachine()

function love.load()
  
  -- Enable the debugging with ZeroBrane Studio
  if arg[#arg] == "-debug" then require("mobdebug").start() end 
  
    -- Loading Scenes in mScenes
  table.insert(mScenes, SS)
  table.insert(mScenes, SM)
  table.insert(mScenes, SG)
  
  for _,v in ipairs(mScenes) do
    v:new()
  end
  
  -- Setting Scene Flow
  SS:setNextSceneID(2)
  SM:setNextSceneID(3)
  SG:setNextSceneID(1)
  
  -- Setting StateMachine like a SceneDirector or similar
  GSM:addState("splash", {enter = function() SS:onEnter() end, exit = function() SS:onExit() end, from = "game"})
  GSM:addState("menu",   {enter = function() SM:onEnter() end, exit = function() SM:onExit() end, from = "splash"})
  GSM:addState("game",   {enter = function() SG:onEnter() end, exit = function() SG:onExit() end, from = "menu"})
  GSM:addState("exit",   {from = "menu"})
  GSM:setInitialState("splash")
  
end

function love.update(dt)
  if ((mScenes[mCurrentScene]:isExitTime()) or (GSM:actState() == "exit")) then
    love.event.quit(0)
  else
    mScenes[mCurrentScene]:update(dt)
    if (mScenes[mCurrentScene]:moveToNextScene()) then mCurrentScene = mScenes[mCurrentScene]:getNextSceneID() end
  end
  
end

function love.draw()
  mScenes[mCurrentScene]:draw()
end

function love.keypressed(key)
  if (key == "escape") then love.event.quit(0) end
  mScenes[mCurrentScene]:keyPressed(key)
end

function love.keyreleased(key)
  mScenes[mCurrentScene]:keyReleased(key)
end

function love.mousepressed(x, y, button, istouch, presses)
  mScenes[mCurrentScene]:mousePressed(x, y, button, istouch, presses)
end
