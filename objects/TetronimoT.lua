require("objects.Tetronimo")

TetronimoT = Tetronimo:extend()

function TetronimoT:new()
    TetronimoT.super.new(self, "T")
    self.form = {{x = 0, y = 1, rotation_point = false},
                 {x = 1, y = 0, rotation_point = false},
                 {x = 1, y = 1, rotation_point = true },
                 {x = 2, y = 1, rotation_point = false}}
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