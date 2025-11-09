wW, wH = love.graphics.getDimensions()

Object = require "object"
World = love.physics.newWorld(0, 9.81 * 64, false)
World:setCallbacks(beginContact, nil, nil, nil)
Grid = require "grid"
Gui = require "gui"


gravity = false
rotation = 0
targetRotation = 0
rotationSpeed = math.rad(90)
rotating = false
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
        for _, body in pairs(World:getBodies()) do
            body:destroy()
        end
        Grid:create()
        Gui:create()
        targetRotation = 0
        rotation = 0
    elseif key == "e" and not rotating then
        targetRotation = targetRotation + math.rad(90)
    end
end

function love.mousepressed(x, y, button)
    if button == 1 then
        Gui:mousepressed(x, y)
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
    end





    -- local aData = fixA:getUserData()
    -- local bData = fixB:getUserData()

    -- -- Identify which fixture is the bounce
    -- local bounceFixture, otherFixture

    -- if aData == "bounce" then
    --     bounceFixture = fixA
    --     otherFixture = fixB
    -- elseif bData == "bounce" then
    --     bounceFixture = fixB
    --     otherFixture = fixA
    -- else
    --     return
    -- end

    -- local bounceBody = bounceFixture:getBody()
    -- local otherBody = otherFixture:getBody()

    -- -- Ignore static bodies
    -- if otherBody:getType() ~= "dynamic" then return end

    -- -- Get bounce angle
    -- local angle = bounceBody:getAngle()

    -- -- Direction vector the bounce is facing
    -- local dirX = math.cos(angle)
    -- local dirY = math.sin(angle)

    -- -- Bounce strength
    -- local strength = 800 -- tweak this to taste

    -- -- Apply impulse at the point of contact
    -- local cx, cy = contact:getPositions()
    -- if cx and cy then
    --     otherBody:applyLinearImpulse(dirX * strength, dirY * strength, cx, cy)
    -- else
    --     -- fallback: apply at center if contact point unavailable
    --     otherBody:applyLinearImpulse(dirX * strength, dirY * strength)
    -- end
end
World:setCallbacks(beginContact, nil, nil, nil)
