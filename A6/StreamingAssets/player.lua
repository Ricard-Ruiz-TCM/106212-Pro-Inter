require "vector2"

function changeDirection()
    local forward = Vector2.FromTable(player:GetForward())

    -- Creamos una dirección forward aleatoria entre -1 y 1 con 2 decimales de precisión
    forward.x = math.random(-100, 100) / 100
    forward.y = math.random(-100, 100) / 100

    -- Normalizamos el vector
    forward:Normalize();

    player:SetForward(forward.x, forward.y)
end

function update(dt)
    local position = Vector2.FromTable(player:GetPosition())
    local forward = Vector2.FromTable(player:GetForward())
    local limits = Vector2.FromTable(player:GetLimits())
    local speed = player:GetSpeed()

    -- Movemos el jugador segun el vector Forward, la velocidad y el delta timea
    position = position + forward * speed * dt;

    -- Comprobamos los limites con la escena para ajustar o no su posición
    if (position.x < -limits.x) then position.x = -limits.x end
    if (position.x >  limits.x) then position.x =  limits.x end
    if (position.y < -limits.y) then position.y = -limits.y end
    if (position.y >  limits.y) then position.y =  limits.y end

    player:SetPosition(position.x, position.y);
end