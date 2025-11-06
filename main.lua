wW, wH = love.graphics.getDimensions()

local grid = require "grid"


function love.load()
    grid:create()
end

function love.draw()
    grid:draw()
end