local gui = {}


function gui:create()

    self.size = 48
    
    self.countX = 2
    self.countY = 3

    self.x = self.size * 12
    self.y = Grid.height - (self.size * self.countY )

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
                func = function ()
                    
                end,
                draw = function ()
                    
                end
            }
        end
    end

end

return gui