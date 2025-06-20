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
local tetronimo_bag = {1, 2, 3, 4, 5, 6, 7} -- 1=T, 2=Z, 3=L, 4=J, 5=O, 6=S, 7=I
local current_tetronimo = nil
local next_tetronimo = nil

function game.load()
    matrix = Matrix()
    matrix:createGrid()

    -- Start game with random piece
    current_tetronimo = tetronimos[love.math.random(1, #tetronimos)](matrix)
    next_tetronimo = tetronimos[love.math.random(1, #tetronimos)](matrix)

    -- Set font
    local font = love.graphics.newFont(24)
    love.graphics.setFont(font)
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

    
    -- Draw border of box that will contain the next piece
    local next_piece_box_top_left_x = Globals.PLAY_AREA_TOP_LEFT_X + (matrix.block_size * matrix.columns) + 25
    local next_piece_box_top_left_y = Globals.PLAY_AREA_TOP_LEFT_Y
    love.graphics.rectangle("line", next_piece_box_top_left_x, next_piece_box_top_left_y, 100, 100)
    

    -- Use next_tetronimo to draw the piece inside the box
    local next_piece_block_size = 20
    love.graphics.setColor(next_tetronimo.colour)
    if next_tetronimo.shape == "O" then
        love.graphics.rectangle("fill",
                                next_piece_box_top_left_x + 30,
                                next_piece_box_top_left_y + 30,
                                40,
                                40)
    else
        for _, block in ipairs(next_tetronimo.form.up) do
            love.graphics.rectangle("fill",
                                    next_piece_box_top_left_x + (next_piece_block_size * block.x) + next_piece_block_size,
                                    next_piece_box_top_left_y + (next_piece_block_size * block.y) + next_piece_block_size,
                                    next_piece_block_size,
                                    next_piece_block_size)
        end
    end
    love.graphics.setColor(1, 1, 1)
end
 
function game.keypressed(key)
    -- Handle game keys
end

function game.spawnTetronimo()
    current_tetronimo = next_tetronimo -- Move next tetronimo to current tetronimo

    -- Choose next tetronimo from the bag
    if #tetronimo_bag == 1 then -- If only 1 tetronimo left in the bag, reset the bag
        next_tetronimo = tetronimos[tetronimo_bag[1]](matrix)
        tetronimo_bag = {1, 2, 3, 4, 5, 6, 7} -- 1=T, 2=Z, 3=L, 4=J, 5=O, 6=S, 7=I
        return
    end

    -- Otherwise, select random tetronimo from the bag
    local index = love.math.random(1, #tetronimo_bag)
    next_tetronimo = tetronimos[tetronimo_bag[index]](matrix) -- Update next tetronimo with new random tetronimo

    -- Remove the chosen tetronimo from the bag
    table.remove(tetronimo_bag, index)
end

return game
