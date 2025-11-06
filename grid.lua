local grid = {

}

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

    for i = 1, #self.grids do
        self.grids[i] = {}
        for j = 1, #self.grids do
            self.grids[i][j] = {
                x = self.x + ((i-1) * self.size),
                y = self.y + ((j-1) * self.size),
                hovering = false,
                occupied = false
            }
        end
    end

end

function grid:draw()
    love.graphics.setLineWidth(0.5)
    
    for i = 1, #self.grids do
        for j = 1, #self.grids[i] do
            if self.grids[i][j].hovering then
                love.graphics.setColor(0.7, 0.7, 1)
            end
            love.graphics.rectangle("line", self.grids[i][j].x, self.grids[i][j].y, self.size, self.size )     
        end
    end

end

return grid