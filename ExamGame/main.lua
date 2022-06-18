
local Splash = Splash or require "Scripts/scenes/Splash"
local Game = Game or require "Scripts/scenes/Game"
local Victory = Victory or require "Scripts/scenes/Victory"

global_current_scene = 1

local SP = Splash()
local SG = Game()
local SV = Victory()

local scenes = {}

function love.load()
  
  table.insert(scenes, SP); SP:new()
  table.insert(scenes, SG); SG:new()
  table.insert(scenes, SV); SV:new()
  
end

function love.update(dt)
  scenes[global_current_scene]:update(dt)
end

function love.draw()
  scenes[global_current_scene]:draw()
end

function love.resize(w,h)
  map:resize(w,h)
end

function love.keyreleased(key)
  SG:keyreleased(key)
end
