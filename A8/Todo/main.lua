local w, h -- Variables to store the screen width and height

local ballX, ballY -- Variables to store the position of the ball in the screen (Uncomment at the start of TODO 6)
local ballSpeed -- Variable to store the ball speed (Uncomment at the start of TODO 8)
local ballState -- Varaible para gestionar el estado de colision de la pelota 1 -> 225º, 2 -> 315º, 3 -> 45º, 4 -> 135º
local playerX, playerY, cpuX, cpuY -- Variables to store the position of the player and cpu paddle (Uncomment at the start of TODO 10)
local paddleSpeed -- Variable to store the paddle speed (Uncomment at the start of TODO 12)
local ballAngle -- Variable to estore the ball movement angle (Uncomment at the start of TODO 16)
local playerPoints, cpuPoints -- Variable to store the player and cpu points (Uncomment at the start of TODO 21)

function love.load(arg)
  if arg[#arg] == "-debug" then require("mobdebug").start() end -- Enable the debugging with ZeroBrane Studio
  
  w, h = love.graphics.getDimensions() -- Get the screen width and height
  
  -- TODO 5: Load the font to use in the game and set it
  love.graphics.setFont(love.graphics.newFont("pong.ttf", 72))
  
  -- TODO 6: Initialize the position of the ball at the center of the screen
  ballX = w / 2
  ballY = h / 2
  
  -- TODO 8: Initialize the ball speed for going to the left
  -- ballSpeed = -2.5
  
  -- TODO 10: Initialize the player and cpu paddles position
  playerX = 20
  playerY = h / 2
  cpuX = w - 30
  cpuY = h / 2
  
  -- TODO 12: Initialize the paddle speed
  paddleSpeed = 5
  
  -- TODO 16: Initialize the ball angle
  ballState = 1
  ballAngle = math.rad(225)
  
  -- TODO 18: Comment all the code of the TODO 8 and initialize the ball speed without sign
  ballSpeed = 2.5
  
  -- TODO 21: Initialize the player and cpu points variables
  playerPoints = 0
  cpuPoints = 0
  
end

function love.update(dt)
  -- TODO 9: Make the ball move using the ballSpeed variable
  -- ballX = ballX + ballSpeed
   
  -- TODO 17: Comment all the code of the TODO 9 and make the ball move using the ballAngle variable
  ballX = ballX + ballSpeed * math.cos(ballAngle);
  ballY = ballY + ballSpeed * math.sin(ballAngle);
  
  -- TODO 13: Move the player paddle getting the up and down arrows keys of the keyboard using the variable paddleSpeed
  if (love.keyboard.isDown("up")) then
    playerY = playerY - paddleSpeed
  end
  
  if (love.keyboard.isDown("down")) then
    playerY = playerY + paddleSpeed
  end
  
  -- TODO 14: Detect the ball collision with the player paddle and make it bounce
  --[[DeltaX = ballX - math.max(playerX, math.min(ballX, playerX + 10));
  DeltaY = ballY- math.max(playerY, math.min(ballY, playerY + 50));
  if (DeltaX * DeltaX + DeltaY * DeltaY) < (10 * 10) then
    ballSpeed = -2.5
  end]]--
  
  -- TODO 15: Detect the ball collision with the cpu paddle and make it bounce
  --[[DeltaX = ballX - math.max(cpuX, math.min(ballX, cpuX + 10));
  DeltaY = ballY- math.max(cpuY, math.min(ballY, cpuY + 50));
  if (DeltaX * DeltaX + DeltaY * DeltaY) < (10 * 10) then
    ballSpeed = 2.5
  end]]--
  
  -- TODO 25: Add the needed code at TODO 19 to make the ball quicker at paddle collision
  -- TODO 19: Comment all the code of the TODO 14 and TODO 15 and make it bounce using the new ball angle
  DeltaX = ballX - math.max(playerX, math.min(ballX, playerX + 10));
  DeltaY = ballY- math.max(playerY, math.min(ballY, playerY + 50));
  if (DeltaX * DeltaX + DeltaY * DeltaY) < (10 * 10) then
    if (ballState == 4) then
      ballState = 3
      ballAngle = math.rad(45)
    elseif (ballState == 1) then
      ballState = 2
      ballAngle = math.rad(315)
    end
    ballSpeed = ballSpeed + 1
  end
  
  DeltaX = ballX - math.max(cpuX, math.min(ballX, cpuX + 10));
  DeltaY = ballY- math.max(cpuY, math.min(ballY, cpuY + 50));
  if (DeltaX * DeltaX + DeltaY * DeltaY) < (10 * 10) then
    if (ballState == 2) then
      ballState = 1
      ballAngle = math.rad(225)
    elseif (ballState == 3) then
      ballState = 4
      ballAngle = math.rad(135)
    end
    ballSpeed = ballSpeed + 1
  end
  
  -- TODO 20: Detect the ball collision with the top and bottom of the field and make it bounce
  if (ballY < 10) then
    if (ballState == 1) then
      ballState = 4
      ballAngle = math.rad(135)
    elseif (ballState == 2) then
      ballState = 3
      ballAngle = math.rad(45)
    end
  end
  
  if (ballY > h - 10) then
    if (ballState == 3) then
      ballState = 2
      ballAngle = math.rad(315)
    elseif (ballState == 4) then
      ballState = 1
      ballAngle = math.rad(225)
    end
  end
  
  
  -- TODO 26: Add the needed code at TODO 23 to reset the ball speed
  -- TODO 23: Detect the ball collision with the player and cpu sides, increse the points accordingly and reset the ball
  if (ballX < 10) then
    cpuPoints = cpuPoints + 1
    ballX = w / 2
    ballY = h / 2
    ballSpeed = 5
  end
  
  if (ballX > w - 10) then
    playerPoints = playerPoints + 1
    ballX = w / 2
    ballY = h / 2
    ballSpeed = 5
  end
  
  -- TODO 24: Make the cpu paddle move to get the ball
  if (ballY < cpuY) then
    cpuY = cpuY - paddleSpeed
  elseif (ballY > cpuY) then
    cpuY = cpuY + paddleSpeed
  else
  end
  
  
end

function love.draw()
  -- TODO 1: Draw the center of the field
  love.graphics.line(w / 2, 0, w / 2, h)
  
  -- TODO 2: Draw the ball at the center of the field
  -- love.graphics.circle("fill", w / 2, h / 2, 10)
  
  -- TODO 3: Draw the player and cpu paddles
  -- love.graphics.rectangle("fill", 20, h / 2, 10, 50) -- Player
  -- love.graphics.rectangle("fill", w - 20 - 10, h / 2, 10, 50) -- CPU
  
  -- TODO 4: Draw the player and cpu points
  -- love.graphics.print("0", w / 3 - 36, 25) -- Player
  -- love.graphics.print("0", w / 1.5, 25) -- CPU
  
  -- TODO 7: Comment all the code of the TODO 2 and use the ballX and ballY variables to draw the ball
  love.graphics.circle("fill", ballX, ballY, 10)
  
  -- TODO 11: Comment all the code of the TODO 3 and use the playerX, playerY, cpuX and cpuY variables to draw the player and cpu paddles
  love.graphics.rectangle("fill", playerX, playerY, 10, 50) -- Player
  love.graphics.rectangle("fill", cpuX, cpuY, 10, 50) -- CPU
  
  -- TODO 22: Comment all the code of the TODO 4 and use the playerPoints and cpuPOints variables to draw the points
  love.graphics.print(tostring(playerPoints), w / 3 - 36, 25) -- Player
  love.graphics.print(tostring(cpuPoints), w / 1.5, 25) -- CPU
  
end