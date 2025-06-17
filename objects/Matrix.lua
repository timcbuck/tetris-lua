Matrix = Object:extend()

function Matrix:new()
    self.columns, self.rows = 10, 20
    self.grid = {} -- 2D array: grid[column][row] = nil or a color/block
    self.block_size = 32
end

function Matrix:createGrid()
    -- Grid will be filled with tetronimo colours when they are placed
    for row = 0, self.rows-1 do
        self.grid[row] = {}
        for col = 0, self.columns-1 do
            self.grid[row][col] = nil
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

    --[[
    -- Draw grid outline
    local horizontal_line_y = Globals.PLAY_AREA_TOP_LEFT_Y + self.block_size
    local vertical_line_x = Globals.PLAY_AREA_TOP_LEFT_X + self.block_size
    -- Draw horizontal line
    for y = 0, self.rows-1 do
        love.graphics.line(Globals.PLAY_AREA_TOP_LEFT_X, horizontal_line_y, Globals.PLAY_AREA_TOP_LEFT_X + self.columns * self.block_size, horizontal_line_y)
        horizontal_line_y = horizontal_line_y + self.block_size
    end
    -- Draw vertical line
    for x = 0, self.columns-1 do
        love.graphics.line(vertical_line_x, Globals.PLAY_AREA_TOP_LEFT_Y, vertical_line_x, Globals.PLAY_AREA_TOP_LEFT_Y + self.rows * self.block_size)
        vertical_line_x = vertical_line_x + self.block_size
    end
    ]]

    -- Draw placed tetronimos
    local x_offset, y_offset = 0, 0
    for y = 0, self.rows-1 do
        x_offset = 0
        for x = 0, self.columns-1 do
            if self.grid[y][x] then
                love.graphics.setColor(self.grid[y][x])
                love.graphics.rectangle("fill",
                                        Globals.PLAY_AREA_TOP_LEFT_X + x_offset,
                                        Globals.PLAY_AREA_TOP_LEFT_Y + y_offset,
                                        self.block_size,
                                        self.block_size)
                love.graphics.setColor(1, 1, 1)
            end
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
    -- Check rows to see if any have a nil column
    -- If none are nil, add row number to cleared_rows
    local cleared_rows = {}
    for row = start_row, end_row do
        local cleared = true
        for col = 0, self.columns-1 do
            if not self.grid[row][col] then
                cleared = false
                break
            end
        end
        if cleared then
            print("row " .. row ..  " is cleared!")
            table.insert(cleared_rows, row)
        end
    end

    return cleared_rows
end

function Matrix:clearRows(cleared_rows)
   -- Sort cleared rows in ascending order
    table.sort(cleared_rows)

    -- Remove blocks in the cleared rows
    for _, row in ipairs(cleared_rows) do
        for col = 0, self.columns - 1 do
            self.grid[row][col] = nil
        end
    end

    -- Move rows down by the number of cleared rows below them
    for row = self.rows - 1, 0, -1 do
        -- Skip if this row was cleared
        local is_cleared = false
        for _, cleared in ipairs(cleared_rows) do
            if row == cleared then
                is_cleared = true
                break
            end
        end
        if is_cleared then goto continue end

        -- Count how many cleared rows are below this row
        local shift = 0
        for _, cleared in ipairs(cleared_rows) do
            if cleared > row then
                shift = shift + 1
            end
        end

        if shift > 0 then
            for col = 0, self.columns - 1 do
                self.grid[row + shift][col] = self.grid[row][col]
                self.grid[row][col] = nil
            end
        end

        ::continue::
    end
end