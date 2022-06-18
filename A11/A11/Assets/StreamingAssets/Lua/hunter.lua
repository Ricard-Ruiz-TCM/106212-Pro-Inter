require "vector2"

local wander_angle = 0

function wander()
    local position = Vector2.FromTable(agent:GetPosition())
    local velocity = Vector2.FromTable(agent:GetVelocity())
    local max_velocity = agent:GetNumberData("max_velocity")
    local max_force = agent:GetNumberData("max_force")
    local max_speed = agent:GetNumberData("max_speed")
    local circle_distance = agent:GetNumberData("circle_distance")
    local circle_radius = agent:GetNumberData("circle_radius")
    local angle_change = agent:GetNumberData("angle_change")
    local mass = agent:GetNumberData("mass")
    
    local circle_center = velocity:Clone()
    circle_center:Normalize()
    circle_center:Mul(circle_distance)
    
    local displacement = Vector2.New(0, -1)
    displacement:Mul(circle_radius)
    
    local m = displacement:Magnitude()
    displacement.x = math.cos(wander_angle) * m
    displacement.y = math.sin(wander_angle) * m
    
    wander_angle = wander_angle + math.random() * angle_change - angle_change * 0.5
    
    velocity = ((circle_center + displacement) / mass):Truncate(max_speed)
        
    return velocity
end

function seekforce()
    local position = Vector2.FromTable(agent:GetPosition())
    local velocity = Vector2.FromTable(agent:GetVelocity())
    local max_velocity = agent:GetNumberData("max_velocity")
    local max_force = agent:GetNumberData("max_force")
    local max_speed = agent:GetNumberData("max_speed")
    local stop_distance = agent:GetNumberData("stop_distance")
    local mass = agent:GetNumberData("mass")
    local target = Vector2.FromTable(agent:GetTarget())
    
    if (target - position):Magnitude() > stop_distance then    
        desired_velocity = (target - position):Normalized() * max_velocity
        steering = (desired_velocity - velocity):Truncated(max_force)
        steering = steering / mass
        print("Velocity: " .. tostring(velocity) .. " Desired: " .. tostring(desired_velocity) .. "Steering: " .. tostring(steering))
        
        velocity = (velocity + steering):Truncated(max_speed)
    else
        velocity = Vector2.zero
    end
    
    return velocity
end

function update()
    local position = Vector2.FromTable(agent:GetPosition())
    local wander_velocity = wander()
    local seek_velocity = seekforce()
    local prey = Vector2.FromTable(agent:GetTarget())
    local seek_magnitude = seek_velocity:Magnitude()
    local stop_distance = agent:GetNumberData("stop_distance")
    local flee_distance = agent:GetNumberData("flee_distance")
    local velocity
    
    if (prey - position):Magnitude() < flee_distance then
        velocity = seek_velocity
    else
        velocity = wander_velocity
    end
    
    local max_speed = agent:GetNumberData("max_speed")
    agent:SetVelocity(velocity.x, velocity.y)
end