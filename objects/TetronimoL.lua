require("objects.Tetronimo")

TetronimoL = Tetronimo:extend()

function TetronimoL:new(matrix)
    TetronimoL.super.new(self, matrix, "L")
    self.form = { up =     {{x = 0, y = 1},
                            {x = 1, y = 1},
                            {x = 2, y = 1},
                            {x = 2, y = 0}},
                  right =  {{x = 1, y = 0},
                            {x = 1, y = 1},
                            {x = 1, y = 2},
                            {x = 2, y = 2}},
                  down =   {{x = 0, y = 2},
                            {x = 0, y = 1},
                            {x = 1, y = 1},
                            {x = 2, y = 1}},
                  left =   {{x = 0, y = 0},
                            {x = 1, y = 0},
                            {x = 1, y = 1},
                            {x = 1, y = 2}}
                }
    self.colour = {229/255, 167/255, 62/255} --orange
end

function TetronimoL:update(dt)
    TetronimoL.super.update(self, dt)
end

function TetronimoL:draw()
    love.graphics.setColor(self.colour)
    TetronimoL.super.draw(self)
    love.graphics.setColor(1, 1, 1)
end