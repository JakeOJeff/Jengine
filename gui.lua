local gui = {}


function gui:create()
    self.size = 48

    self.countX = 2
    self.countY = 3

    self.x = self.size * 12
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
        return Object:newCirc(World, cell.x, cell.y, self.size, "dynamic", 0)
    end
    staticCircle.draw = function(cell)
        local radius = self.size / 2
        love.graphics.setColor(1, 1, 1)
        love.graphics.circle("line", cell.x + radius, cell.y + radius, radius)
    end

end

function gui:update()
    local mx, my = love.mouse.getPosition()

    for i = 1, self.countX do
        for j = 1, self.countY do
            local cell = self.buttons[i][j]
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
            love.graphics.setColor(1, 1, 1)
            love.graphics.rectangle("line", cell.x, cell.y, self.size, self.size)

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
            else
                cell.selected = false
            end
        end
    end
end

return gui
