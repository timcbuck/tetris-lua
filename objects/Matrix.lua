Matrix = Object:extend()

function Matrix:new()
    self.columns, self.rows = 10, 20
    self.block_size = 32
end

function Matrix:update(dt)
end

function Matrix:draw()
    love.graphics.rectangle("line",
                            Globals.PLAY_AREA_TOP_LEFT_X,
                            Globals.PLAY_AREA_TOP_LEFT_Y,
                            self.columns * self.block_size,
                            self.rows * self.block_size)
end