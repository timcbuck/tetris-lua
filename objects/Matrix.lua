Matrix = Object:extend()

function Matrix:new()
    self.columns, self.rows = 10, 20
    self.grid = {} -- 2D array: grid[column][row] = nil or a color/block
    self.block_size = 32
end

function Matrix:createGrid()
    for y = 1, self.rows do
        self.grid[y] = {}
        for x = 1, self.columns do
            self.grid[y][x] = nil
        end
    end
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

function Matrix:addTetronimo()
end

function Matrix:printGrid()
    for y = 1, self.rows do
        local rowStr = ""
        for x = 1, self.columns do
            if self.grid[y][x] then
                rowStr = rowStr .. "X "
            else
                rowStr = rowStr .. ". "
            end
        end
        print(rowStr)
    end
end