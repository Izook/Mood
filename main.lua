-- Load values at the start of the program
function love.load()

    -- Constant Values
    SCREEN_WIDTH = love.graphics.getWidth();
    SCREEN_HEIGHT = love.graphics.getHeight();

    -- Game Values
    frameCount = 0  

    -- Rectangle Starting Values
    rectPosX = 20
    rectPosY = 20
    rectWidth = 50
    rectHeight = 50

    -- Rectangle Color Values
    rectColorR = 0
    rectColorG = 100
    rectColorB = 100

    -- Rectangle Motion Values
    rectMovingUp = false;
    rectMovingRight = true;
    rectVelocityX = 5;
    rectVelocityY = 5;

    -- Setting Mood Values
    moodDisplacement = 0;
    mood = "A"
end
 
-- Draw Each Frame
function love.draw()
    -- Set Graphics Color
    love.graphics.setColor(rectColorR, rectColorG, rectColorB)

    -- Draw Rectangle on Screen
    love.graphics.rectangle("fill", rectPosX, rectPosY, rectWidth, rectHeight)

    -- Display Frame Count and Velocity
    local frameString = "Frame: "..frameCount -- Using '..' to concat strings
    love.graphics.print(frameString, 0, 0) 
    love.graphics.print(("Velocity X: "..rectVelocityX), 0, 20);
    love.graphics.print(("Velocity Y: "..rectVelocityY), 0, 40);
    love.graphics.print("MOOD", 700, 500)

    -- Add & Display Mood 
    mood = mood.."A"

    if(string.len(mood)>70)
    then
        moodDisplacement = moodDisplacement - 3
        love.graphics.print(mood, moodDisplacement, SCREEN_HEIGHT-20)
    else
        love.graphics.print(mood, 0, SCREEN_HEIGHT-20)
    end

end

-- Update Variables Each Frame
function love.update(dt)

    -- Move Rectangle According to Y Direction
    if(rectMovingUp) 
    then
        rectPosY = rectPosY + rectVelocityY
    else
        rectPosY = rectPosY - rectVelocityY
    end

    -- Move Rectangle According to X Direction
    if(rectMovingRight) 
    then
        rectPosX = rectPosX + rectVelocityX
    else
        rectPosX = rectPosX - rectVelocityX
    end

    -- Get Rectangle Collision Info
    local collidedRight = (rectPosX + rectWidth) >= SCREEN_WIDTH
    local collidedLeft = rectPosX <= 0
    local collidedUp = rectPosY <= 0
    local collidedDown = (rectPosY + rectHeight) >= SCREEN_HEIGHT

    -- Change Direction on Collision
    if (collidedRight or collidedLeft or collidedUp or collidedDown) 
    then
        rectMovingUp = not rectMovingUp
        rectMovingRight = not rectMovingRight
    end

    --Reposition on Out of Bounds X Position
    if (collidedRight) 
    then
        rectPosX = SCREEN_WIDTH - rectWidth
    end
    if (collidedLeft) 
    then
        rectPosX = 0
    end

    --Reposition on Out of Bounds Y Position
    if (collidedDown) 
    then
        rectPosY = SCREEN_HEIGHT - rectHeight
    end
    if (collidedUp) 
    then
        rectPosY = 0
    end

    -- Adjusting Velocities
    local adjustmentX = love.math.random(-8,8)
    local adjustmentY = love.math.random(-8,8)

    rectVelocityX = rectVelocityX + adjustmentX
    rectVelocityY = rectVelocityY + adjustmentY
 
    -- Maxing Velocity
    if (rectVelocityX > 10)
    then
        rectVelocityX = 10
    end

    if (rectVelocityY > 10)
    then
        rectVelocityY = 10
    end

    -- Minimizing Velocity
    if (rectVelocityX < -10)
    then
        rectVelocityX = -10
    end

    if (rectVelocityY < -10)
    then
        rectVelocityY = -10
    end

    -- Getting Random New Color Values
    local newColorR = love.math.random(1,255)
    local newColorG = love.math.random(1,255)
    local newColorB = love.math.random(1,255)

    -- Setting New Rectangle Color 
    rectColorR = newColorR
    rectColorG = newColorG
    rectColorB = newColorB

    -- Incrementing Frame Count
    frameCount = frameCount + 1
end

