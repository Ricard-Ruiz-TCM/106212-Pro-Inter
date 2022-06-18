-----------------------------------------------------------------
-- ///////////////////////////////////////////////////////// DATA
-----------------------------------------------------------------
local w, h = love.graphics.getDimensions()

DATA = {}

DATA.Ball = {}
DATA.Ball.Position = {}
DATA.Ball.Position.x = 400
DATA.Ball.Position.y = 300
DATA.Ball.Speed = 250

DATA.Player = {}
DATA.Player.Position = {}
DATA.Player.Position.x = 20
DATA.Player.Position.y = 300
DATA.Player.Speed = 250

DATA.CPU = {}
DATA.CPU.Position = {}
DATA.CPU.Position.x = 770
DATA.CPU.Position.y = 300
DATA.CPU.Speed = 250

DATA.Scene = {}
DATA.Scene.Intro = {}
DATA.Scene.Intro.Button = {}
DATA.Scene.Intro.Button.Play = {}
DATA.Scene.Intro.Button.Play.Text = "PLAY"
DATA.Scene.Intro.Button.Play.TextSize = 72
DATA.Scene.Intro.Button.Play.TextColor = {0, 0, 0, 1}
DATA.Scene.Intro.Button.Play.Position = {}
DATA.Scene.Intro.Button.Play.Position.x = 245 
DATA.Scene.Intro.Button.Play.Position.y = 200

DATA.Scene.Intro.Button.Exit = {}
DATA.Scene.Intro.Button.Exit.Text = "EXIT"
DATA.Scene.Intro.Button.Exit.TextSize = 72
DATA.Scene.Intro.Button.Exit.TextColor = {0, 0, 0, 1}
DATA.Scene.Intro.Button.Exit.Position = {}
DATA.Scene.Intro.Button.Exit.Position.x = 245 
DATA.Scene.Intro.Button.Exit.Position.y = 300 

DATA.Scene.Intro.Button.Ranking = {}
DATA.Scene.Intro.Button.Ranking.Text = "RANKING"
DATA.Scene.Intro.Button.Ranking.TextSize = 72
DATA.Scene.Intro.Button.Ranking.TextColor = {0, 0, 0, 1}
DATA.Scene.Intro.Button.Ranking.Position = {}
DATA.Scene.Intro.Button.Ranking.Position.x = 245 
DATA.Scene.Intro.Button.Ranking.Position.y = 400 

DATA.Scene.Intro.Button.Text_Ranking = {}
DATA.Scene.Intro.Button.Text_Ranking.y = 210

DATA.Scene.Intro.Texture = {}
DATA.Scene.Intro.Texture.Ranking = {}
DATA.Scene.Intro.Texture.Ranking.x = 179
DATA.Scene.Intro.Texture.Ranking.y = 336 
DATA.Scene.Intro.Texture.Ranking.w = 443
DATA.Scene.Intro.Texture.Ranking.h = 222 

DATA.Scene.Over = {}
DATA.Scene.Over.Button = {}
DATA.Scene.Over.Button.Replay = {}
DATA.Scene.Over.Button.Replay.Position = {}
DATA.Scene.Over.Button.Replay.Position.x = 670
DATA.Scene.Over.Button.Replay.Position.y = 416

DATA.Scene.Over.Button.Exit = {}
DATA.Scene.Over.Button.Exit.Position = {}
DATA.Scene.Over.Button.Exit.Position.x = 670
DATA.Scene.Over.Button.Exit.Position.y = 520

DATA.Scene.Over.Button.Text = {}
DATA.Scene.Over.Button.Text.Size = {}
DATA.Scene.Over.Button.Text.Size = 36

DATA.Scene.Over.Button.Text_Winner= {}
DATA.Scene.Over.Button.Text_Winner.Position = {}
DATA.Scene.Over.Button.Text_Winner.Position.x = w / 2
DATA.Scene.Over.Button.Text_Winner.Position.y = 145

DATA.Scene.Over.Button.Text_1= {}
DATA.Scene.Over.Button.Text_1.Position = {}
DATA.Scene.Over.Button.Text_1.Position.x = 170
DATA.Scene.Over.Button.Text_1.Position.y = 265

DATA.Scene.Over.Button.Text_2 = {}
DATA.Scene.Over.Button.Text_2.Position = {}
DATA.Scene.Over.Button.Text_2.Position.x = 200
DATA.Scene.Over.Button.Text_2.Position.y = 265

DATA.Scene.Over.Button.Text_3 = {}
DATA.Scene.Over.Button.Text_3.Position = {}
DATA.Scene.Over.Button.Text_3.Position.x = 230
DATA.Scene.Over.Button.Text_3.Position.y = 265

DATA.Scene.Over.Button.Text_Time = {}
DATA.Scene.Over.Button.Text_Time.Position = {}
DATA.Scene.Over.Button.Text_Time.Position.x = 250
DATA.Scene.Over.Button.Text_Time.Position.y = 265

DATA.Scene.Over.Button.Text_Ranking = {}
DATA.Scene.Over.Button.Text_Ranking.Position = {}
DATA.Scene.Over.Button.Text_Ranking.Position.x = w / 4
DATA.Scene.Over.Button.Text_Ranking.Position.y = 372
DATA.Scene.Over.Button.Text_Ranking.Size = 28

DATA.Scene.Over.ArrowSelectro = {}
DATA.Scene.Over.ArrowSelectro.x = 145
DATA.Scene.Over.ArrowSelectro.y = 285
DATA.Scene.Over.ArrowSelectro.offset = 30

DATA.Scene.Play = {}
DATA.Scene.Play.WinCondition = 3

return DATA

-----------------------------------------------------------------