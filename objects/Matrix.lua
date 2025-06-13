Matrix = Object:extend()

function Matrix:new()
    self.columns, self.rows = 10, 20
    self.grid = {} -- 2D array: grid[column][row] = nil or a color/block
    self.block_size = 32
end

function Matrix:createGrid()
    -- Grid will be filled with tetronimo colours when they are placed
    for y = 0, self.rows-1 do
        self.grid[y] = {}
        for x = 0, self.columns-1 do
            self.grid[y][x] = nil
        end
    end
end

function Matrix:update(dt)
end

function Matrix:draw()
    -- Draw grid border
    love.graphics.rectangle("line",
                            Globals.PLAY_AREA_TOP_LEFT_X,
                            Globals.PLAY_AREA_TOP_LEFT_Y,
                            self.columns * self.block_size,
                            self.rows * self.block_size)

    -- Draw grid outline

    -- Draw grid (colour the squares based on what tetronimos have been placed)
    local x_offset, y_offset = 0, 0
    for y = 0, self.rows-1 do
        x_offset = 0
        for x = 0, self.columns-1 do
            if self.grid[y][x] then love.graphics.setColor(self.grid[y][x]) else love.graphics.setColor(0, 0, 0) end
            love.graphics.rectangle("fill",
                                    Globals.PLAY_AREA_TOP_LEFT_X + x_offset,
                                    Globals.PLAY_AREA_TOP_LEFT_Y + y_offset,
                                    self.block_size,
                                    self.block_size)
            love.graphics.setColor(1, 1, 1)
            x_offset = x_offset + self.block_size
        end
        y_offset = y_offset + self.block_size
    end
end

function Matrix:placeTetronimo(tetronimo)
    local block_x, block_y
    local x_offset, y_offset = tetronimo.x_offset, tetronimo.y_offset
    for _, block in ipairs(tetronimo.form[tetronimo.orientation]) do
        -- Get the x and y position of each block in the tetronimo
        block_x = block.x + x_offset
        block_y = block.y + y_offset
        -- Update the matrix grid with new block position
        print("Block X = " .. block_x)
        print("Block Y = " .. block_y)
        self.grid[block_y][block_x] = tetronimo.colour
    end
    self:printGrid() --debug
end

function Matrix:printGrid()
    print("GRID UPDATE: ")
    for y = 0, self.rows-1 do
        local rowStr = ""
        for x = 0, self.columns-1 do
            if self.grid[y][x] then
                rowStr = rowStr .. "X "
            else
                rowStr = rowStr .. ". "
            end
        end
        print(rowStr)
    end
end

function Matrix:isEmptyCell(x, y)
    if self.grid[y][x] then return false else return true end
end

function Matrix:getClearedRows(start_row, end_row)
    local rows_cleared = {}
    for r = start_row, end_row do
        table.insert(rows_cleared, r)
    end
    -- TODO: still working on this....
end