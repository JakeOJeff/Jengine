wW, wH = love.graphics.getDimensions()

Object = require "object"
World = love.physics.newWorld(0, 9.81 * 64, false)
local grid = require "grid"

gravity = false

function love.load()
    grid:create()
end
function love.update(dt)
    World:update(dt)
    grid:update()
            if gravity then
            World:setGravity(0, 9.81 * 64)
            print("Gravity ON")
        else
            World:setGravity(0, 0)
            print("Gravity OFF")
            for _, body in pairs(World:getBodies()) do
                body:setLinearVelocity(0, 0)
                body:setAngularVelocity(0)
            end
        end
end
function love.draw()
    grid:draw()
end

function love.keypressed(key, scancode, isrepeat)
    if key == "space" then
        gravity = not gravity


    end
end