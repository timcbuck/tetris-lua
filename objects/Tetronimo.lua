Tetronimo = Object:extend()

function Tetronimo:new(matrix, shape)
    if self.__index == Tetronimo then
        error("Tetronimo is an abstract base class and should not be instantiated directly")
    end
    self.matrix = matrix -- needs to query the matrix instance when moving to a new position
    self.shape = shape
    self.block_size = Globals.BLOCK_SIZE
    self.form = nil -- overridden in subclass
    self.x_offset = 3
    self.y_offset = 0
    self.orientation = "up" -- 1=up, 2=right, 3=down, 4=left
    self.fall_speed = Globals.fall_speed
    self.fall_timer = Timer()
    self.is_placed = false

    self.fall_timer:every(self.fall_speed, function() self:fall() end)

    print(self.matrix)
end

function Tetronimo:update(dt)
    if not self.is_placed then
        self:move()
        self:rotate()
        self.fall_timer:update(dt)
    end
end

function Tetronimo:draw()
    for _, block in ipairs(self.form[self.orientation]) do
        love.graphics.rectangle("fill",
                                Globals.PLAY_AREA_TOP_LEFT_X + (self.block_size * block.x) + (self.block_size * self.x_offset),
                                Globals.PLAY_AREA_TOP_LEFT_Y + (self.block_size * block.y) + (self.block_size * self.y_offset),
                                self.block_size,
                                self.block_size)
    end
end

function Tetronimo:rotate()
    local initial_orientation = self.orientation

    if input:pressed("rotate") then
        if self.orientation == "up" then
            self.orientation = "right"
        elseif self.orientation == "right" then
            self.orientation = "down"
        elseif self.orientation == "down" then
            self.orientation = "left"
        else
            self.orientation = "up"
        end
    end

    if not self:canMove(self.x_offset, self.y_offset) then self.orientation = initial_orientation end
end

function Tetronimo:move()
    if input:down("right", Globals.MOVE_SPEED) then
        if self:canMove(self.x_offset + 1, self.y_offset) then self.x_offset = self.x_offset + 1 end
    end
    if input:down("left", Globals.MOVE_SPEED) then
        if self:canMove(self.x_offset - 1, self.y_offset) then self.x_offset = self.x_offset - 1 end
    end
    if input:down("down", Globals.MOVE_SPEED) then
        if self:canMove(self.x_offset, self.y_offset + 1) then self.y_offset = self.y_offset + 1 else self.is_placed = true end
    end
end

function Tetronimo:fall()
    if not input:down("down") then -- don't fall automatically if user is already moving down
        if self:canMove(self.x_offset, self.y_offset + 1) then self.y_offset = self.y_offset + 1 else self.is_placed = true end
    end
end

function Tetronimo:canMove(new_x_offset, new_y_offset)
    if self.form then -- self.form is defined in subclass, so it will be nil briefly when object first created
        for _, block in ipairs(self.form[self.orientation]) do
            -- Prevent moving outside the matrix grid
            if block.x + new_x_offset > 9 or block.x + new_x_offset < 0 then return false end
            if block.y + new_y_offset > 19 then return false end
            -- TODO: Check if new x/y are occupied by another block (by querying the Matrix object?)
            if not self.matrix:isEmptyCell(block.x + new_x_offset, block.y + new_y_offset) then return false end
        end
    end
    return true
end

function Tetronimo:getStartRow()
    -- Return the first row that this tetronimo is placed on
    local min_y = self.form[self.orientation][1].y
    for _, block in ipairs(self.form[self.orientation]) do
        min_y = (block.y < min_y) and block.y or min_y
    end
    return min_y + self.y_offset
end

function Tetronimo:getEndRow()
    -- Get the last row that this tetronimo is placed on
    local max_y = self.form[self.orientation][1].y
    for _, block in ipairs(self.form[self.orientation]) do
        max_y = (block.y > max_y) and block.y or max_y
    end
    return max_y + self.y_offset
end