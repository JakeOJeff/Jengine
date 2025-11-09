local grid = {}

function grid:create()
    local size = 24
    self.x = size
    self.y = size
    
    self.countX = 20
    self.countY = 20
    self.size = size
    
    self.width = self.size * self.countX
    self.height = self.size * self.countY
    
    self.grids = {}

    -- Default shape creator (rectangle)
    self.func = function(cell)
        return Object:newRect(World, cell.x, cell.y, self.size, self.size, "dynamic", 0)
    end

    -- Alternate shape creators
    self.createTriangle = function(cell)
        local x, y = cell.x + self.size / 2, cell.y + self.size / 2
        local half = self.size / 2
        -- Equilateral triangle points centered in the cell
        local vertices = {
            x, y - half,       -- top
            x - half, y + half, -- bottom left
            x + half, y + half  -- bottom right
        }
        return Object:newTri(World, vertices, "dynamic", 0)
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

    -- Border walls
    Object:newRect(World, self.x, self.y - 1, self.width, 1, "static", 0)
    Object:newRect(World, self.x + self.width + 1, self.y, 1, self.height, "static", 0)
    Object:newRect(World, self.x - 1, self.y, 1, self.height, "static", 0)
    Object:newRect(World, self.x, self.y + self.height + 1, self.width, 1, "static", 0)
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
                love.graphics.setColor(0.7, 0.7, 1, 0.3)
                love.graphics.rectangle("fill", cell.x, cell.y, self.size, self.size)
                love.graphics.setColor(1, 1, 1)

                for k = 1, Gui.countX do
                    for m = 1, Gui.countY do
                        if Gui.buttons[k][m].func == Grid.func then
                            Gui.buttons[k][m].draw(cell)
                        end
                    end
                end
            else
                love.graphics.setColor(1, 1, 1)
                if self.grids[i][j].obj then
                    local obj = self.grids[i][j].obj
                    local body = obj.body
                    for _, fixture in pairs(body:getFixtures()) do
                        local shape = fixture:getShape()
                        local shapeType = shape:getType()
                        local bodyType = body:getType()
                        local fillType = bodyType == "static" and "fill" or "line"

                        love.graphics.push()
                        love.graphics.setLineWidth(2)

                        if shapeType == "polygon" then
                            if not obj.imagery then
                                local points = {body:getWorldPoints(shape:getPoints())}
                                love.graphics.polygon(fillType, points)
                            elseif obj.imagery then
                                local bx, by = body:getPosition()
                                local angle = body:getAngle()

                                local sx, sy = 1, 1
                                if obj.size and obj.img then
                                    local iw, ih = obj.img:getWidth(), obj.img:getHeight()

                                    sx = obj.size / iw
                                    sy = obj.size / ih
                                end

                                if obj.img then
                                    love.graphics.draw(obj.img, bx, by, angle, sx, sy, obj.img:getWidth() /2, obj.img:getHeight()/2)
                                end
                            end

                        elseif shapeType == "circle" then
                            local bx, by = body:getPosition()
                            local sx, sy = shape:getPoint()
                            local angle = body:getAngle()
                            local radius = shape:getRadius()
                            local cx = bx + math.cos(angle) * sx - math.sin(angle) * sy
                            local cy = by + math.sin(angle) * sx + math.cos(angle) * sy
                            love.graphics.circle(fillType, cx, cy, radius)
                        end

                        love.graphics.pop()
                    end
                end
            end
        end
    end

end


return grid
