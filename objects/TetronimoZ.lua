require("objects.Tetronimo")

TetronimoZ = Tetronimo:extend()

function TetronimoZ:new()
    TetronimoZ.super.new(self, "T")
    self.form = { up =     {{x = 0, y = 0},
                            {x = 1, y = 0},
                            {x = 1, y = 1},
                            {x = 2, y = 1}},
                  right =  {{x = 1, y = 0},
                            {x = 1, y = 1},
                            {x = 0, y = 1},
                            {x = 0, y = 2}},
                  down =   {{x = 0, y = 0},
                            {x = 1, y = 0},
                            {x = 1, y = 1},
                            {x = 2, y = 1}},
                  left =   {{x = 1, y = 0},
                            {x = 1, y = 1},
                            {x = 0, y = 1},
                            {x = 0, y = 2}}
                }
    self.colour = {240, 0, 0} --red
end

function TetronimoZ:update(dt)
    TetronimoZ.super.update(self, dt)
end

function TetronimoZ:draw()
    love.graphics.setColor(self.colour)
    TetronimoZ.super.draw(self)
    love.graphics.setColor(1, 1, 1)
end