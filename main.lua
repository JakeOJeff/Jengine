wW, wH = love.graphics.getDimensions()

Object = require "object"
World = love.physics.newWorld(0, 9.81 * 64, false)
Grid = require "grid"
Gui = require "gui"

gravity = false

function love.load()
    Grid:create()
end
function love.update(dt)
    World:update(dt)
    Grid:update()
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
    Grid:draw()
end

function love.keypressed(key, scancode, isrepeat)
    if key == "space" then
        gravity = not gravity

    elseif key == "r" then
        for _, body in pairs(World:getBodies()) do
            body:destroy()
        end
        Grid:create()
    end
end 