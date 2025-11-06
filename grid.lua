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

end

function grid:draw()
    love.graphics.setLineWidth(0.5)
    
    for i = 0, self.countX do
        for j = 0, self.countY do
            love.graphics.rectangle("line", self.x + i * self.size, self.y + j * self.size, self.size, self.size )     
        end
    end

end

return grid