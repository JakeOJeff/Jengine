local grid = {}

function grid:create()
    local size = 48
    self.x = size
    self.y = size
    
    self.countX = 10
    self.countY = 10
    self.size = size
    
    self.width = self.size * self.countX
    self.height = self.size * self.countY
    
    self.grids = {}
    self.func = function (cell)
        return Object:newRect(World, cell.x, cell.y, self.size, self.size, "dynamic", 0)
    end

    for i = 1, self.countX do
        self.grids[i] = {}
        for j = 1, self.countY do
            self.grids[i][j] = {
                x = self.x + ((i - 1) * self.size),
                y = self.y + ((j - 1) * self.size),
                hovering = false,
                occupied = false
            }
        end
    end
    Object:newRect(World, self.x, self.y - 1, self.width, 1,"static", 0)
    Object:newRect(World, self.x + self.width + 1, self.y, 1, self.height,"static", 0)

    Object:newRect(World, self.x - 1, self.y, 1, self.height,"static", 0)
    Object:newRect(World, self.x, self.y + self.height + 1, self.width, 1,"static", 0)
end

function grid:update()
    local mx, my = love.mouse.getPosition()

    for i = 1, self.countX do
        for j = 1, self.countY do
            local cell = self.grids[i][j]
            if mx > cell.x and mx < cell.x + self.size and
               my > cell.y and my < cell.y + self.size then
                cell.hovering = true

                if love.mouse.isDown(1) and not cell.obj then
                    cell.obj = self.func(cell)
                end

            else
                cell.hovering = false
            end
        end
    end
end

function grid:draw()
    love.graphics.setLineWidth(0.5)
    
    for i = 1, self.countX do
        for j = 1, self.countY do
            local cell = self.grids[i][j]

            if not gravity then
                love.graphics.rectangle("line", cell.x, cell.y, self.size, self.size)
            end
                love.graphics.setColor(1,1,1)

            if cell.hovering then
                love.graphics.setColor(0.7, 0.7, 1)
                love.graphics.rectangle("fill", cell.x, cell.y, self.size, self.size) 
            else
                love.graphics.setColor(1, 1, 1)
            end
        end
    end
    for _, body in pairs(World:getBodies()) do
        -- You can get the fixtures attached to this body
        for _, fixture in pairs(body:getFixtures()) do
            local shape = fixture:getShape()
            local shapeType = shape:getType()

            if shapeType == "polygon" then
                -- For rectangles
                local x, y = body:getPosition()
                local angle = body:getAngle()
                local points = {body:getWorldPoints(shape:getPoints())}

                love.graphics.push()
                love.graphics.polygon("fill", points)
                love.graphics.pop()
            end
            if shapeType == "circle" then
                local bx, by = body:getPosition()
                local sx, sy = shape:getPoint()      -- circle's local offset relative to body
                local radius = shape:getRadius()
                local angle = body:getAngle()
                local type = body:getType()
                local fillType = type == "static" and "fill" or "line" 

                -- Calculate actual world-space center of the circle
                local cx = bx + math.cos(angle) * sx - math.sin(angle) * sy
                local cy = by + math.sin(angle) * sx + math.cos(angle) * sy

                love.graphics.push()
                love.graphics.translate(cx, cy)
                love.graphics.rotate(angle)
                love.graphics.circle(fillType, 0, 0, radius)
                love.graphics.pop()
            end
        end
    end
end

return grid
