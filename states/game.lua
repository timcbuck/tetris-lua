require("objects.Matrix")
require("objects.TetronimoT")

local game = {}

function game.load()
    matrix = Matrix()
    current_tetronimo = TetronimoT()
end

function game.update(dt)
    matrix:update(dt)
    current_tetronimo:update(dt)
end

function game.draw()
    matrix:draw()
    current_tetronimo:draw()
end

function game.keypressed(key)
    -- Handle game keys
end

return game
