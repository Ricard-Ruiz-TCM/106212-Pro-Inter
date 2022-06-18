
-- Engine
local Scene = Scene or require "src/engine/Scene"
local Entity = Entity or require "src/engine/Entity"
local UIText = UITtxt or require "src/engine/UIText"

-- Game Entities
local UIButton = Button or require "src/engine/UIButton"

-- Singletons
local Score = Score or require "src/score"

-- Data
local D = DATA or require "data"

-- Locals
local mBackgroundID = -1
local mButtonPlayID = -1
local mButtonExitID = -1
local mButtonRankingID = -1

local mTextRankingListID = -1

local w, h = love.graphics.getDimensions()

-- Class
local SceneGameIntro = Scene:extend()
-------------------------------------

function SceneGameIntro:new()
  SceneGameIntro.super.new(self)
  ------------------------------
  
  -- Background
  mBackgroundID = self:addEntity(Entity(0, 0, 0, "assets/textures/scene_intro.png"))
  
  -- Buttons
  mButtonPlayID = self:addEntity(UIButton(D.Scene.Intro.Button.Play.Position.x, D.Scene.Intro.Button.Play.Position.y, 0, "assets/textures/button.png", "assets/textures/button_hover.png", function() self:nextScene() end, D.Scene.Intro.Button.Play.Text, D.Scene.Intro.Button.Play.TextSize, D.Scene.Intro.Button.Play.TextColor))
  mButtonExitID = self:addEntity(UIButton(D.Scene.Intro.Button.Exit.Position.x, D.Scene.Intro.Button.Exit.Position.y, 0, "assets/textures/button.png", "assets/textures/button_hover.png", function() self:exitNow() end, D.Scene.Intro.Button.Exit.Text, D.Scene.Intro.Button.Exit.TextSize, D.Scene.Intro.Button.Exit.TextColor))
  mButtonRankingID = self:addEntity(UIButton(D.Scene.Intro.Button.Ranking.Position.x, D.Scene.Intro.Button.Ranking.Position.y, 0, "assets/textures/button.png", "assets/textures/button_hover.png", function() self:toggleRanking() end, D.Scene.Intro.Button.Ranking.Text, D.Scene.Intro.Button.Ranking.TextSize, D.Scene.Intro.Button.Ranking.TextColor))
  
  -- Ranking Frame
  self.ranking_bg = love.graphics.newImage("assets/textures/scene_game_over.png")
  self.ranking_text = UIText(D.Scene.Over.Button.Text_Ranking.Position.x, D.Scene.Intro.Button.Text_Ranking.y, "", "left", D.Scene.Over.Button.Text_Ranking.Size)
  self.ranking_frame = love.graphics.newQuad(D.Scene.Intro.Texture.Ranking.x, D.Scene.Intro.Texture.Ranking.y, D.Scene.Intro.Texture.Ranking.w, D.Scene.Intro.Texture.Ranking.h, self.ranking_bg:getWidth(), self.ranking_bg:getHeight())
  self.showing_ranking = false
end

function SceneGameIntro:toggleRanking()
  if (self.showing_ranking == false) then
    self.showing_ranking = true
    self.ranking_text:setText(Score:getRankingStr())
  else
    self.showing_ranking = false
    self.ranking_text:setText("")
  end
end

function SceneGameIntro:update(dt)
  SceneGameIntro.super.update(self, dt)
  -------------------------------------
end

function SceneGameIntro:draw()
  SceneGameIntro.super.draw(self)
  -------------------------------
  if (self.showing_ranking == true) then
    love.graphics.setColor(1, 1, 1, 1)
    love.graphics.draw(self.ranking_bg, self.ranking_frame, D.Scene.Intro.Texture.Ranking.x, D.Scene.Intro.Texture.Ranking.x)
    self.ranking_text:draw()
  end
end

function SceneGameIntro:reload()
  SceneGameIntro.super.reload(self)
  ---------------------------------
  self.showing_ranking = false
end

function SceneGameIntro:keyPressed(key)
  SceneGameIntro.super.keyPressed(self, key)
  ------------------------------------------
  if (key ~= "") then
    self.showing_ranking = false
    self.ranking_text:setText("")
  end
end

return SceneGameIntro
