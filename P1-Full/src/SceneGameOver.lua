
-- Libs
local Vector = Vector or require "lib/vector"

-- Engine
local Scene = Scene or require "src/engine/Scene"
local Entity = Entity or require "src/engine/Entity"
local Actor = Actor or require "src/engine/Actor"
local UIButton = Button or require "src/engine/UIButton"
local UIText = UIText or require "src/engine/UIText"

-- Singeltons
local Score = Score or require "src/Score"

-- Data
local D = DATA or require "data"

-- Locals
local mBackgroundID = -1

local mArrowSelectorID = -1

local mButtonReplayID = -1
local mButtonExitID = -1

local mTextWinnerID = -1
local mTextIndex1ID = -1
local mTextIndex2ID= -1
local mTextIndex3ID = -1 
local mTextScoreTimeID = -1
local mTextRankingListID = -1

local mKeyUp = false
local mKeyDown = false

local mInput = true
local mIndex = 1

local w, h = love.graphics.getDimensions()

-- Class
local SceneGameOver = Scene:extend()
------------------------------------

function SceneGameOver:new()
  SceneGameOver.super.new(self)
  -----------------------------
    
  -- Background
  mBackgroundID = self:addEntity(Entity(0, 0, 0, "assets/textures/scene_game_over.png"))
  
  -- Arrow Selector
  mArrowSelectorID = self:addEntity(Actor(-50, -50, 0, "assets/textures/arrow_selector.png", 50))
  
  -- Buttons
  mButtonReplayID = self:addEntity(UIButton(D.Scene.Over.Button.Replay.Position.x, D.Scene.Over.Button.Replay.Position.y, 0, "assets/textures/button_replay.png", "assets/textures/button_replay_hover.png", function() self:nextScene() end))
  mButtonExitID = self:addEntity(UIButton(D.Scene.Over.Button.Exit.Position.x, D.Scene.Over.Button.Exit.Position.y, 0, "assets/textures/button_exit.png", "assets/textures/button_exit_hover.png", function() self:exitNow() end))
  
  -- Texts
  mTextWinnerID = self:addEntity(UIText(D.Scene.Over.Button.Text_Winner.Position.x, D.Scene.Over.Button.Text_Winner.Position.y, "¡¡WINNER!!", "center", 72))
  mTextIndex1ID = self:addEntity(UIText(D.Scene.Over.Button.Text_1.Position.x, D.Scene.Over.Button.Text_1.Position.y, "A", "center", D.Scene.Over.Button.Text.Size))
  mTextIndex2ID = self:addEntity(UIText(D.Scene.Over.Button.Text_2.Position.x, D.Scene.Over.Button.Text_2.Position.y, "A", "center", D.Scene.Over.Button.Text.Size))
  mTextIndex3ID = self:addEntity(UIText(D.Scene.Over.Button.Text_3.Position.x, D.Scene.Over.Button.Text_3.Position.y, "A", "center", D.Scene.Over.Button.Text.Size))
  mTextScoreTimeID = self:addEntity(UIText(D.Scene.Over.Button.Text_Time.Position.x, D.Scene.Over.Button.Text_Time.Position.y, "", "left", D.Scene.Over.Button.Text.Size))
  mTextRankingListID = self:addEntity(UIText(D.Scene.Over.Button.Text_Ranking.Position.x, D.Scene.Over.Button.Text_Ranking.Position.y, "", "left", D.Scene.Over.Button.Text_Ranking.Size))
  
end

function SceneGameOver:update(dt)
  SceneGameOver.super.update(self, dt)    
  ------------------------------------
  if (mInput == true) then
    if (mIndex > 3) then
      self:addToRanking()
    else
      
      -- Move Arrow Selector
      self:getEntity(mArrowSelectorID).forward.y = math.cos(self.time * 10)
      
      -- Get current "A"
      local t = nil
      if (mIndex == 1) then
        t = self:getEntity(mTextIndex1ID)
      elseif (mIndex == 2) then
        t = self:getEntity(mTextIndex2ID)
      elseif (mIndex == 3) then
        t = self:getEntity(mTextIndex3ID)
      end
      
      -- Update "A" from A -> Z and Z -> A
      local asci = string.byte(t.text)
      if (mKeyUp) then
        asci = asci + 1
        if (asci > 90) then
          asci = 65
        end
        mKeyUp = false
      end
      if (mKeyDown) then
        asci = asci - 1
        if (asci < 65) then
          asci = 90
        end
        mKeyDown = false
      end
      t:setText(string.char(asci))
      
    end
  end
  
end

function SceneGameOver:draw()
  SceneGameOver.super.draw(self)
  ------------------------------
end

function SceneGameOver:keyPressed(key)
  SceneGameOver.super.keyPressed(self, key)
  -----------------------------------------
  if (key == "up") then
    mKeyUp = true
  end
  if (key == "down") then
    mKeyDown = false
  end
end

function SceneGameOver:keyReleased(key)
  SceneGameOver.super.keyReleased(self, key)
  ------------------------------------------
  if (key == "space") then
    mIndex = mIndex + 1
    
    if (mIndex == 2) then
      self:getEntity(mArrowSelectorID).position.x = self:getEntity(mArrowSelectorID).position.x + D.Scene.Over.ArrowSelectro.offset
    elseif (mIndex == 3) then
      self:getEntity(mArrowSelectorID).position.x = self:getEntity(mArrowSelectorID).position.x + D.Scene.Over.ArrowSelectro.offset
    else
      self:getEntity(mArrowSelectorID).position = Vector.new(-50, -50)
    end
    
  end
  if (key == "up") then
    mKeyUp = false
  end
  if (key == "down") then
    mKeyDown = true
  end
end

function SceneGameOver:reload()
  SceneGameOver.super.reload(self)
  ---------------------------------
  mIndex = 1
  mInput = true
  
  Score.game_time = tonumber(string.format("%.2f", tostring(Score.game_time)))
    
  -- CPU Wins
  if (Score:whoWins() ~= true) then
    self:getEntity(mTextWinnerID):setText("U LOSE!!")
    self:getEntity(mTextIndex1ID):setText("C")
    self:getEntity(mTextIndex2ID):setText("P")
    self:getEntity(mTextIndex3ID):setText("U")
    self:addToRanking()
  else  -- Player WINS
    self:getEntity(mTextWinnerID):setText("U WIN!!")
    self:getEntity(mTextIndex1ID):setText("A")
    self:getEntity(mTextIndex2ID):setText("A")
    self:getEntity(mTextIndex3ID):setText("A")
    self:getEntity(mArrowSelectorID).position = Vector.new(D.Scene.Over.ArrowSelectro.x, D.Scene.Over.ArrowSelectro.y)
  end
  
  self:getEntity(mTextScoreTimeID):setText(" reach 3pt in " .. Score.game_time .."s")
  self:updateRanking()
end

function SceneGameOver:addToRanking()
  mInput = false
  Score:addToRanking(self:getEntity(mTextIndex1ID).text .. self:getEntity(mTextIndex2ID).text .. self:getEntity(mTextIndex3ID).text)
  self:updateRanking()
end

function SceneGameOver:updateRanking()
  self:getEntity(mTextRankingListID):setText(Score:getRankingStr())
end

return SceneGameOver
