require("objects.Tetronimo")

TetronimoI = Tetronimo:extend()

function TetronimoI:new(matrix)
    TetronimoI.super.new(self, matrix, "I")
    self.form = { up =     {{x = 2, y = 0},
                            {x = 2, y = 1},
                            {x = 2, y = 2},
                            {x = 2, y = 3}},
                  right =  {{x = 0, y = 2},
                            {x = 1, y = 2},
                            {x = 2, y = 2},
                            {x = 3, y = 2}},
                  down =   {{x = 2, y = 0},
                            {x = 2, y = 1},
                            {x = 2, y = 2},
                            {x = 2, y = 3}},
                  left =   {{x = 0, y = 2},
                            {x = 1, y = 2},
                            {x = 2, y = 2},
                            {x = 3, y = 2}}
                }
    self.colour = {110/255, 236/255, 238/255} --light blue
end

function TetronimoI:update(dt)
    TetronimoI.super.update(self, dt)
end

function TetronimoI:draw()
    love.graphics.setColor(self.colour)
    TetronimoI.super.draw(self)
    love.graphics.setColor(1, 1, 1)
end