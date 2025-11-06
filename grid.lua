local grid = {

}

function grid:create()
    self.x = 0
    self.y = 0
    
    self.countX = 50
    self.countY = 50

    self.size = 48
    
    self.width = self.size * self.countX
    self.height = self.size * self.countY

end

return grid