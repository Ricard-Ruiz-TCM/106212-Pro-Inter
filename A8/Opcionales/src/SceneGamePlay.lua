
-- Engine
local Scene = Scene or require "src/engine/Scene"
local Entity = Entity or require "src/engine/Entity"
local Timer = Timer or require "src/engine/Timer"
local UIText = UIText or require "src/engine/UIText"
local SimpleAudio = SimpleAudio or require "src/engine/SimpleAudio"

-- Game Entities
local Ball = Ball or require "src/Ball"
local Paddle = Paddle or require "src/Paddle"

-- Singeltons
local Score = Score or require "src/Score"

-- Data
local D = DATA or require "data"

-- Locals
local mBackgroundID = -1

local mBallID = -1
local mPlayerID = -1
local mCPUID = -1

local mTextPlayerScoreID = -1
local mTextCPUScoreID = -1

local mTimer = Timer()

local w, h = love.graphics.getDimensions()

-- Class
local SceneGamePlay = Scene:extend()
------------------------------------

function SceneGamePlay:new()
  SceneGamePlay.super.new(self)
  -----------------------------
  
  -- Background
  mBackgroundID = self:addEntity(Entity(0, 0, 0, "assets/textures/scene_pong.png"))
  
  -- Game Entities
  mPlayerID = self:addEntity(Paddle(D.Player.Position.x, D.Player.Position.y, 0, "assets/textures/player_skin.png", D.CPU.Speed))
  mCPUID = self:addEntity(Paddle(D.CPU.Position.x, D.CPU.Position.y, 0, "assets/textures/player_skin.png", D.Player.Speed))
  mBallID = self:addEntity(Ball(D.Ball.Position.x, D.Ball.Position.y, 0, "assets/textures/ball_skin.png", D.Ball.Speed))
  
  -- Texts
  local t = {1,1,1,1}
  mTextPlayerScoreID = self:addEntity(UIText(w / 3.9, 70, "0", "center", 72, t))
  mTextCPUScoreID = self:addEntity(UIText(w / 1.325, 70, "0", "center", 72, t))
  
end

function SceneGamePlay:update(dt)
  self.super.update(self, dt)
  ---------------------------
  mTimer:update(dt)
  
  -- Getting entities to handle
  local ball = self:getEntity(mBallID)
  local player = self:getEntity(mPlayerID)
  local cpu = self:getEntity(mCPUID)
  
  -- Check Collision with Player & Cpu
  if ((ball:intersectEntity(player)) or (ball:intersectEntity(cpu))) then
    ball:paddleCollision()
    SimpleAudio:playAudio("ball_paddle_paddle")
  end
  
  -- Make CPU follows the Ball
  cpu:follow(ball)
  
  -- Check goals with Ball Left and Right Limits
  if (ball:leftLimit()) then
    SimpleAudio:playAudio("goal_fx")
    cpu:increaseScore()
    ball:reload()
    self:getEntity(mTextCPUScoreID):setText(cpu.score)
  end
  if (ball:rightLimit()) then
    SimpleAudio:playAudio("goal_fx")
    player:increaseScore()
    ball:reload()
    self:getEntity(mTextPlayerScoreID):setText(player.score)
  end
  
  -- Check the winning condition for player & cpu
  if (cpu.score >= D.Scene.Play.WinCondition) then
    self:nextScene()
    Score:cpuWins()
    Score:setMathTime(mTimer.time)
  end
  if (player.score >= D.Scene.Play.WinCondition) then
    self:nextScene()
    Score:playerWins()
    Score:setMathTime(mTimer.time)
  end
  
  player.position.y = ball.position.y
  
end

function SceneGamePlay:draw()
  self.super.draw(self)
  ---------------------
end

function SceneGamePlay:reload()
  SceneGamePlay.super.reload(self)
  ---------------------------------
  mTimer:restart()
  
  self:getEntity(mTextPlayerScoreID):setText("0")
  self:getEntity(mTextCPUScoreID):setText("0")
  
end

function SceneGamePlay:keyPressed(key)
  SceneGamePlay.super.keyPressed(self, key)
  ------------------------------------------
  self:getEntity(mPlayerID):keyPressed(key)
end

function SceneGamePlay:keyReleased(key)
  SceneGamePlay.super.keyReleased(self, key)
  ------------------------------------------
  self:getEntity(mPlayerID):keyReleased(key)
end

return SceneGamePlay
