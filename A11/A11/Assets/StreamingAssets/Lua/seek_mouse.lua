require "vector2"

function update()
    local position = Vector2.FromTable(agent:GetPosition())
    local velocity = Vector2.FromTable(agent:GetVelocity())
    local max_velocity = agent:GetNumberData("max_velocity")
    local max_force = agent:GetNumberData("max_force")
    local max_speed = agent:GetNumberData("max_speed")
    local stop_distance = agent:GetNumberData("stop_distance")
    local target = Vector2.FromTable(agent:GetMousePosition())
    local mass = agent:GetNumberData("mass")
    
    if (target - position):Magnitude() > stop_distance then    
        desired_velocity = (target - position):Normalized() * max_velocity
        steering = (desired_velocity - velocity):Truncated(max_force)
        steering = steering / mass
        print("Velocity: " .. tostring(velocity) .. " Desired: " .. tostring(desired_velocity) .. "Steering: " .. tostring(steering))
        
        velocity = (velocity + steering):Truncated(max_speed)
    else
        velocity = Vector2.zero
    end
    
    agent:SetVelocity(velocity.x, velocity.y)
end