require("objects.Tetronimo")

TetronimoS = Tetronimo:extend()

function TetronimoS:new(matrix)
    TetronimoS.super.new(self, matrix, "S")
    self.form = { up =     {{x = 0, y = 1},
                            {x = 1, y = 0},
                            {x = 1, y = 1},
                            {x = 2, y = 0}},
                  right =  {{x = 1, y = 0},
                            {x = 1, y = 1},
                            {x = 2, y = 1},
                            {x = 2, y = 2}},
                  down =   {{x = 0, y = 2},
                            {x = 1, y = 2},
                            {x = 1, y = 1},
                            {x = 2, y = 1}},
                  left =   {{x = 0, y = 0},
                            {x = 0, y = 1},
                            {x = 1, y = 1},
                            {x = 1, y = 2}}
                }
    self.colour = {110/255, 236/255, 71/255} --green
end

function TetronimoS:update(dt)
    TetronimoS.super.update(self, dt)
end

function TetronimoS:draw()
    love.graphics.setColor(self.colour)
    TetronimoS.super.draw(self)
    love.graphics.setColor(1, 1, 1)
end