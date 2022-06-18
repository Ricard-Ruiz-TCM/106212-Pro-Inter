
-- Scenes
local SceneGameIntro = SceneGameIntro or require "src/SceneGameIntro" -- ID 1
local SceneGamePlay = SceneGamePlay or require "src/SceneGamePlay"    -- ID 2
local SceneGameOver = SceneGameOver or require "src/SceneGameOver"    -- ID 3

-- Singletons
local Score = Score or require "src/Score"
local SimpleAudio = SimpleAudio or require "src/engine/SimpleAudio"


-- Locals
local mCurrentScene = 1
local mScenes = {}

local w, h = love.graphics.getDimensions()

function love.load(arg)
  -- Enable the debugging with ZeroBrane Studio
  if arg[#arg] == "-debug" then require("mobdebug").start() end 
  
  -- Setting Pong Font
  love.graphics.setFont(love.graphics.newFont("assets/fonts/pong.ttf", 72))
  
  -- Load Singletons
  Score:loadSingleton()
  SimpleAudio:loadSingleton()
  
  -- Setting Scene Flow
  SceneGameIntro:setNextSceneID(2)
  SceneGamePlay:setNextSceneID(3)
  SceneGameOver:setNextSceneID(2)
  
  -- Loading Scenes in mScenes
  table.insert(mScenes, SceneGameIntro)
  table.insert(mScenes, SceneGamePlay)
  table.insert(mScenes, SceneGameOver)

  for _,v in ipairs(mScenes) do
    v:new()
  end
  
end

function love.update(dt)
  
  if (mScenes[mCurrentScene]:isExitTime() == false) then
    
    mScenes[mCurrentScene]:update(dt)
    
    if (mScenes[mCurrentScene]:moveToNextScene() == true) then
      mCurrentScene = mScenes[mCurrentScene]:getNextSceneID()
      mScenes[mCurrentScene]:reload()
    end
    
  else
    love.event.quit(0)
  end
  
end

function love.draw()
  mScenes[mCurrentScene]:draw()
end

function love.keypressed(key)
  mScenes[mCurrentScene]:keyPressed(key)
end

function love.keyreleased(key)
  mScenes[mCurrentScene]:keyReleased(key)
end

function love.mousepressed(x, y, button, istouch, presses)
  mScenes[mCurrentScene]:mousePressed(x, y, button, istouch, presses)
end

