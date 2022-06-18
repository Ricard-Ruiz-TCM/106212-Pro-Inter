
local Object = Object or require "Scripts/Object"

local Victory = Object:extend()

local w,h = love.graphics.getDimensions()

function Victory:new()

end

function Victory:update(dt)
end

function Victory:draw()
  love.graphics.print("YOU WIN GG WP", w / 2 - 25, h / 2)
end


return Victory