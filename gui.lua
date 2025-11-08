local gui = {}


function gui:create()
    self.size = 24

    self.countX = 2
    self.countY = 3

    self.x = self.size * 2 * 12
    self.y = Grid.height - (self.size * self.countY)

    self.width = self.size * self.countX
    self.height = self.size * self.countY

    self.buttons = {}

    for i = 1, self.countX do
        self.buttons[i] = {}

        for j = 1, self.countY do
            self.buttons[i][j] = {
                x = self.x + ((i - 1) * self.size),
                y = self.y + ((j - 1) * self.size),
                hovering = false,
                seleted = false,
                func = function()

                end,
                draw = function ()
                    
                end
            }
        end
    end

    local staticCircle = self.buttons[1][1]
    staticCircle.func = function(cell)
        return Object:newCirc(World, cell.x, cell.y, self.size, "static", rotation)
    end
    staticCircle.draw = function(cell)
        local radius = self.size / 2
        love.graphics.circle("fill", cell.x + radius, cell.y + radius, radius)
    end
    local dynamicCircle = self.buttons[2][1]
    dynamicCircle.func = function(cell)
        return Object:newCirc(World, cell.x + 1, cell.y + 1, self.size - 1, "dynamic", rotation)
    end
    dynamicCircle.draw = function(cell)
        local radius = self.size / 2
        love.graphics.setLineWidth(3)
        love.graphics.circle("line", cell.x + radius + 1, cell.y + radius + 1, radius - 1)
        love.graphics.setLineWidth(1)
    end

    local staticRect = self.buttons[1][2]
    staticRect.func = function(cell)
        return Object:newRect(World, cell.x, cell.y, self.size, self.size, "static", rotation)
    end
    staticRect.draw = function(cell)
        love.graphics.rectangle("fill", cell.x, cell.y, self.size, self.size)
    end
    local dynamicRect = self.buttons[2][2]
    dynamicRect.func = function(cell)
        return Object:newRect(World, cell.x, cell.y, self.size, self.size, "dynamic", rotation)
    end
    dynamicRect.draw = function(cell)
        love.graphics.push()
        love.graphics.translate(cell.x, cell.y)
        love.graphics.rotate(rotation)
        love.graphics.setLineWidth(3)
        love.graphics.rectangle("line", 0, 0, self.size, self.size)
        love.graphics.setLineWidth(1)
        love.graphics.pop()
    end

    local staticTri = self.buttons[1][3]
    staticTri.func = function(cell)
        return Object:newTri(World, cell.x, cell.y, self.size, "static", rotation)
    end
    staticTri.draw = function(cell)
        local half = self.size / 2
        local x, y = cell.x + half, cell.y + half

        love.graphics.push()
        love.graphics.translate(x, y)
        love.graphics.rotate(rotation)
        love.graphics.polygon("fill",
            half,  -half,
            half, half,
            -half , half
        )
        love.graphics.pop()
    end
    local dynamicTri = self.buttons[2][3]
    dynamicTri.func = function(cell)
        return Object:newTri(World, cell.x, cell.y, self.size, "dynamic", rotation)
    end
    dynamicTri.draw = function(cell)
        local half = self.size / 2
        local x, y = cell.x + half, cell.y + half

        love.graphics.push()
        love.graphics.translate(x , y)
        love.graphics.rotate(rotation)
        love.graphics.polygon("line",
            half, -half,
            half, half,
            -half, half
        )
        love.graphics.pop()
    end
end

function gui:update()
    local mx, my = love.mouse.getPosition()
    for i = 1, self.countX do
        for j = 1, self.countY do
            local cell = self.buttons[i][j]
            if Grid.func == cell.func then
                cell.selected = true
            else
                cell.selected = false
            end
            if mx > cell.x and mx < cell.x + self.size and
                my > cell.y and my < cell.y + self.size then
                cell.hovering = true
            else
                cell.hovering = false
            end
        end
    end
end

function gui:draw()
    love.graphics.setLineWidth(1)
    for i = 1, self.countX do
        for j = 1, self.countY do
            local cell = self.buttons[i][j]
            if cell.hovering then
                love.graphics.setColor(0.7, 0.7, 1)
                love.graphics.rectangle("fill", cell.x, cell.y, self.size, self.size)
            end
            if cell.selected then
                love.graphics.setColor(1,1,1,0.5)
            else
                love.graphics.setColor(1, 1, 1)
                love.graphics.rectangle("line", cell.x, cell.y, self.size, self.size)
            end

            cell.draw(cell)
        end
    end
end

function gui:mousepressed(mx, my)
    for i = 1, self.countX do
        for j = 1, self.countY do
            local cell = self.buttons[i][j]
            if mx > cell.x and mx < cell.x + self.size and
                my > cell.y and my < cell.y + self.size then
                Grid.func = cell.func
                cell.selected = true
            end
        end
    end
end

return gui
