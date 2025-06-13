require("objects.Matrix")
require("objects.TetronimoT")
require("objects.TetronimoZ")
require("objects.TetronimoL")
require("objects.TetronimoJ")
require("objects.TetronimoO")
require("objects.TetronimoS")
require("objects.TetronimoI")


local game = {}
local matrix = nil
local tetronimos = {TetronimoT, TetronimoZ, TetronimoL, TetronimoJ, TetronimoO, TetronimoS, TetronimoI}
local current_tetronimo = nil

function game.load()
    matrix = Matrix()
    matrix:createGrid()
    matrix:printGrid()

    --game.spawnTetronimo()
    current_tetronimo = TetronimoI(matrix)
end

function game.update(dt)
    matrix:update(dt)
    current_tetronimo:update(dt)

    if current_tetronimo.is_placed then
        matrix:placeTetronimo(current_tetronimo)
        local placed_start_row = current_tetronimo:getStartRow()
        local placed_end_row = current_tetronimo:getEndRow()
        local cleared_rows = matrix:getClearedRows(placed_start_row, placed_end_row)
        if #cleared_rows > 0 then matrix:clearRows(cleared_rows) end
        game.spawnTetronimo()
    end
end

function game.draw()
    matrix:draw()
    current_tetronimo:draw()
end

function game.keypressed(key)
    -- Handle game keys
end

function game.spawnTetronimo()
    local index = love.math.random(1, #tetronimos)
    current_tetronimo = tetronimos[index](matrix) -- Instantiate tetronimo
end

return game
