wW, wH = love.graphics.getDimensions()

Object = require "object"
World = love.physics.newWorld(0, 9.81 * 64, false)
local grid = require "grid"


function love.load()
    grid:create()
end
function love.update(dt)
    World:update(dt)
    grid:update()
end
function love.draw()
    grid:draw()
end

