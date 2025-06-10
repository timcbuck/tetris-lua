require("objects.Tetronimo")

TetronimoT = Tetronimo:extend()

function TetronimoT:new(matrix)
    TetronimoT.super.new(self, matrix, "T")
    self.form = { up =     {{x = 0, y = 1},
                            {x = 1, y = 0},
                            {x = 1, y = 1},
                            {x = 2, y = 1}},
                  right =  {{x = 1, y = 0},
                            {x = 1, y = 1},
                            {x = 2, y = 1},
                            {x = 1, y = 2}},
                  down =   {{x = 1, y = 2},
                            {x = 0, y = 1},
                            {x = 1, y = 1},
                            {x = 2, y = 1}},
                  left =   {{x = 1, y = 0},
                            {x = 1, y = 1},
                            {x = 1, y = 2},
                            {x = 0, y = 1}}
                }
    self.colour = {160, 0, 240} --purple
end

function TetronimoT:update(dt)
    TetronimoT.super.update(self, dt)
end

function TetronimoT:draw()
    love.graphics.setColor(self.colour)
    TetronimoT.super.draw(self)
    love.graphics.setColor(1, 1, 1)
end