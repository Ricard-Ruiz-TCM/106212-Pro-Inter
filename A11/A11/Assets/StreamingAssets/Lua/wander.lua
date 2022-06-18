require "vector2"

local wander_angle = 0

function update()
    local position = Vector2.FromTable(agent:GetPosition())
    local velocity = Vector2.FromTable(agent:GetVelocity())
    local max_velocity = agent:GetNumberData("max_velocity")
    local max_force = agent:GetNumberData("max_force")
    local max_speed = agent:GetNumberData("max_speed")
    local circle_distance = agent:GetNumberData("circle_distance")
    local circle_radius = agent:GetNumberData("circle_radius")
    local angle_change = agent:GetNumberData("angle_change")
    
    local circle_center = velocity:Clone()
    circle_center:Normalize()
    circle_center:Mul(circle_distance)
    
    local displacement = Vector2.New(0, -1)
    displacement:Mul(circle_radius)
    
    local m = displacement:Magnitude()
    displacement.x = math.cos(wander_angle) * m
    displacement.y = math.sin(wander_angle) * m
    
    wander_angle = wander_angle + math.random() * angle_change - angle_change * 0.5
    
    velocity = (circle_center + displacement):Truncate(max_speed)
        
    agent:SetVelocity(velocity.x, velocity.y)
end