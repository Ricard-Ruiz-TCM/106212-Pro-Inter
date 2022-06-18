
-- Lib
local Object = Object or require "lib/classic"
local Vector = Vector or require "lib/vector"
local Lume = Lume or require "lib/lume"
local CSV = CSV or require "lib/simplecsv"
-- Engine
local Entity = Entity or require "src/engine/Entity"
local Actor = Actor or require "src/engine/Actor"
local Timer = Timer or require "src/engine/Timer"
local Scene = Scene or require "src/engine/Scene"
local AnimatedActor = AnimatedActor or require "src/engine/AnimatedActor"
-- UI Engine
local UIButton = UIButton or require "src/engine/UI/UIButton"
local UIText = UIText or require "src/engine/UI/UIText"
-- Singletons
Audio = Audio or require "src/engine/Audio"
Video = Video or require "src/engine/Video"
Director = Director or require "src/engine/Director"


-- Locals IDS para las entities
local hof_header_index = -1
local hof_lines_text_index = {}

-- Class
local SceneHOF = Scene:extend()
--------------------------------

--[[ Constructor ]]
function SceneHOF:new(id)
  -- Super -------------------
  SceneHOF.super.new(self, id)
  ----------------------------
  
  -- Contenedor de la información del CSV
  self.hof_csv_data = {}
  
  -- Creamos los objetos de texto
  hof_header_index = self:addEntity(UIText(Video:width() / 2, 100, "Header", "center", 38))
  for i = 1, 5, 1 do
    table.insert(hof_lines_text_index, self:addEntity(UIText(Video:width() / 2, i * 65 + 100, tostring(i), "center", 36)))
  end
  
end

--[[ On Enter ]]
function SceneHOF:onEnter()
  -- Super -------------------
  SceneHOF.super.onEnter(self)
  ----------------------------
  self:loadCSV()
  self:updateData()
end

--[[ On Exit Method ]]
function SceneHOF:onExit()
  -- Super ------------------
  SceneHOF.super.onExit(self)
  ---------------------------
  self:removeAllEntities()
end

--[[ loadCSV ]]
function SceneHOF:loadCSV()
  self.hof_csv_data = CSV.read("assets/datafiles/hof.csv")
end

--[[ Update CSV Data ]]
function SceneHOF:updateData()
  local str = ""
  for i,v in ipairs(self.hof_csv_data) do
    str = ""
    for j,k in ipairs(v) do str = str .. k .. "   " end
    if (i == 1) then self:getEntity(hof_header_index):setText(str)
    else self:getEntity(hof_lines_text_index[i - 1]):setText(str) end
  end
end

return SceneHOF

-----------------------------------------------------------------
