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
end

function grid:update()
    local mx, my = love.mouse.getPosition()

    for i = 1, self.countX do
        for j = 1, self.countY do
            local cell = self.grids[i][j]
            if mx > cell.x and mx < cell.x + self.size and
               my > cell.y and my < cell.y + self.size then
                cell.hovering = true

                if love.mouse.isDown(1) then
                    cell.obj = Object:newRect(World, cell.x, cell.y, self.size, self.size, "dynamic", 0)
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

            love.graphics.rectangle("line", cell.x, cell.y, self.size, self.size)

            if cell.obj then
                love.graphics.setColor(1,1,1)
                love.graphics.rectangle("fill", cell.obj.x, cell.obj.y, cell.obj.width, cell.obj.height)
            end
            if cell.hovering then
                love.graphics.setColor(0.7, 0.7, 1)
                love.graphics.rectangle("fill", cell.x, cell.y, self.size, self.size) 
            else
                love.graphics.setColor(1, 1, 1)
            end
        end
    end
end

return grid
