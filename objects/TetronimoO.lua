require("objects.Tetronimo")

TetronimoO = Tetronimo:extend()

function TetronimoO:new(matrix)
    TetronimoO.super.new(self, matrix, "O")
    self.form = { up =     {{x = 1, y = 0},
                            {x = 2, y = 0},
                            {x = 1, y = 1},
                            {x = 2, y = 1}},
                  right =  {{x = 1, y = 0},
                            {x = 2, y = 0},
                            {x = 1, y = 1},
                            {x = 2, y = 1}},
                  down =   {{x = 1, y = 0},
                            {x = 2, y = 0},
                            {x = 1, y = 1},
                            {x = 2, y = 1}},
                  left =   {{x = 1, y = 0},
                            {x = 2, y = 0},
                            {x = 1, y = 1},
                            {x = 2, y = 1}}
                }
    self.colour = {240/255, 240/255, 78/255} --orange
end

function TetronimoO:update(dt)
    TetronimoO.super.update(self, dt)
end

function TetronimoO:draw()
    love.graphics.setColor(self.colour)
    TetronimoO.super.draw(self)
    love.graphics.setColor(1, 1, 1)
end