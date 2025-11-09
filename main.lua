wW, wH = love.graphics.getDimensions()

Object = require "object"
World = love.physics.newWorld(0, 9.81 * 64, false)
World:setCallbacks(beginContact, nil, nil, postSolve)
Grid = require "grid"
Gui = require "gui"


gravity = false
rotation = 0
targetRotation = 0
rotationSpeed = math.rad(90)
rotating = false
ScaleFactor = 2
function love.load()
    Grid:create()
    Gui:create()
end

function love.update(dt)
    World:update(dt)
    Grid:update()
    Gui:update()
    if gravity then
        World:setGravity(0, 9.81 * 64)
    else
        World:setGravity(0, 0)
        for _, body in pairs(World:getBodies()) do
            body:setLinearVelocity(0, 0)
            body:setAngularVelocity(0)
        end
    end


    if rotation < targetRotation then
        rotation = rotation + rotationSpeed * dt
        rotating = true
    else
        rotating = false
    end
    collectgarbage("collect")
end

function love.draw()
    Grid:draw()
    Gui:draw()
end

function love.keypressed(key, scancode, isrepeat)
    if key == "space" then
        gravity = not gravity
                targetRotation = 0
        rotation = 0

    elseif key == "r" then
        resetState()
    elseif key == "e" and not rotating then
        targetRotation = targetRotation + math.rad(90)
    end
end

function love.mousepressed(x, y, button)
    if button == 1 then
        Gui:mousepressed(x, y)
    end
end

function love.wheelmoved(x, y)
    if love.keyboard.isDown("lctrl") then
        if y > 0 then
            ScaleFactor = ScaleFactor + 1
            resetState()
        elseif y < 0 then
            if ScaleFactor > 1 then
                ScaleFactor = ScaleFactor - 1
                resetState()
            end
        end
    end
end


function beginContact(fixA, fixB, contact)

    local aUserData = fixA:getUserData()
    local bUserData = fixB:getUserData()

    local bounceFixture, dynamicFixture

    if aUserData == "bounce" then
        bounceFixture = fixA
        dynamicFixture = fixB
    elseif bUserData == "bounce" then
        bounceFixture = fixB
        dynamicFixture = fixA
    else
        return
    end

    local bounceBody = bounceFixture:getBody()
    local dynamicBody = dynamicFixture:getBody()

    if dynamicBody:getType() ~= "dynamic" then return end

    local angle = bounceBody:getAngle()

    local dirX = math.sin(angle)
    local dirY = math.cos(angle)

    local strength = 400

    local cx, cy = contact:getPositions()

    if cx and cy then
        dynamicBody:applyLinearImpulse(dirX * strength, -dirY * strength)
    else
        dynamicBody:applyLinearImpulse(dirX * strength, -dirY * strength)
    end

end

function postSolve(fixA, fixB, contact)
    local aUserData = fixA:getUserData()
    local bUserData = fixB:getUserData()

    local bounceFixture, dynamicFixture

    if aUserData == "bounce" then
        bounceFixture = fixA
        dynamicFixture = fixB
    elseif bUserData == "bounce" then
        bounceFixture = fixB
        dynamicFixture = fixA
    else
        return
    end

    local bounceBody = bounceFixture:getBody()
    local dynamicBody = dynamicFixture:getBody()

    if dynamicBody:getType() ~= "dynamic" then return end

    local angle = bounceBody:getAngle()

    local dirX = math.sin(angle)
    local dirY = math.cos(angle)

    local strength = 400

    local cx, cy = contact:getPositions()

    if cx and cy then
        dynamicBody:applyLinearImpulse(dirX * strength, -dirY * strength)
    else
        dynamicBody:applyLinearImpulse(dirX * strength, -dirY * strength)
    end
end

function resetState()
    for _, body in pairs(World:getBodies()) do
        body:destroy()
    end
    Grid:create()
    Gui:create()
    targetRotation = 0
    rotation = 0
end
World:setCallbacks(beginContact, nil, nil, nil)
