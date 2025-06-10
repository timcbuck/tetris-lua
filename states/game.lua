require("objects.Matrix")
require("objects.TetronimoT")
require("objects.TetronimoZ")

local game = {}
local tetronimos = {TetronimoT, TetronimoZ}
local current_tetronimo = nil

function game.load()
    matrix = Matrix()
    matrix:createGrid()
    matrix:printGrid()

    game.spawnTetronimo()
end

function game.update(dt)
    matrix:update(dt)
    current_tetronimo:update(dt)

    if current_tetronimo.is_placed then
        matrix:placeTetronimo(current_tetronimo)
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
    current_tetronimo = tetronimos[index]() -- Instantiate tetronimo
end

return game
