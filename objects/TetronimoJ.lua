require("objects.Tetronimo")

TetronimoJ = Tetronimo:extend()

function TetronimoJ:new(matrix)
    TetronimoJ.super.new(self, matrix, "J")
    self.form = { up =     {{x = 0, y = 0},
                            {x = 0, y = 1},
                            {x = 1, y = 1},
                            {x = 2, y = 1}},
                  right =  {{x = 2, y = 0},
                            {x = 1, y = 0},
                            {x = 1, y = 1},
                            {x = 1, y = 2}},
                  down =   {{x = 0, y = 1},
                            {x = 1, y = 1},
                            {x = 2, y = 1},
                            {x = 2, y = 2}},
                  left =   {{x = 1, y = 0},
                            {x = 1, y = 1},
                            {x = 1, y = 2},
                            {x = 0, y = 2}}
                }
    self.colour = {0, 0, 230/255} --dark blue
end

function TetronimoJ:update(dt)
    TetronimoJ.super.update(self, dt)
end

function TetronimoJ:draw()
    love.graphics.setColor(self.colour)
    TetronimoJ.super.draw(self)
    love.graphics.setColor(1, 1, 1)
end