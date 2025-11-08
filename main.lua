wW, wH = love.graphics.getDimensions()

Object = require "object"
World = love.physics.newWorld(0, 9.81 * 64, false)
Grid = require "grid"
Gui = require "gui"


gravity = false
rotation = 0
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
    Gui:draw()
end

function love.keypressed(key, scancode, isrepeat)
    if key == "space" then
        gravity = not gravity

    elseif key == "r" then
        for _, body in pairs(World:getBodies()) do
            body:destroy()
        end
        Grid:create()
    elseif key == "e" then
        rotation = rotation + math.rad(90)
    end
end 
function love.mousepressed(x, y, button)
    if button == 1 then
        Gui:mousepressed(x, y)
    end
end
