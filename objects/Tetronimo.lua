Tetronimo = Object:extend()

function Tetronimo:new(shape)
    if self.__index == Tetronimo then
        error("Tetronimo is an abstract base class and should not be instantiated directly")
    end
    self.shape = shape
    self.block_size = Globals.BLOCK_SIZE
    self.form = nil -- overridden in subclass
    self.x_offset = 3
    self.y_offset = 0
    self.orientation = "up" -- 1=up, 2=right, 3=down, 4=left
    self.fall_speed = Globals.fall_speed
    self.fall_timer = Timer()

    self.fall_timer:every(self.fall_speed, function() self:fall() end)
end

function Tetronimo:update(dt)
    self:move()
    self:rotate()
    self.fall_timer:update(dt)
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
        if self:canMove(self.x_offset, self.y_offset + 1) then self.y_offset = self.y_offset + 1 end
    end
end

function Tetronimo:fall()
    local new_y_offset = self.y_offset + 1
    -- TODO: check if it can move down
    if not input:down("down") then -- don't fall automatically if already moving down
        if self:canMove(self.x_offset, self.y_offset + 1) then self.y_offset = self.y_offset + 1 end
    end
end

function Tetronimo:canMove(new_x_offset, new_y_offset)
    if self.form then -- self.form is defined in subclass, so it will be nil briefly when object first created
        for _, block in ipairs(self.form[self.orientation]) do
            if block.x + new_x_offset > 9 or block.x + new_x_offset < 0 then return false end
            if block.y + new_y_offset > 19 then return false end
            -- TODO: Block is going to overlap another block in the matrix
        end
    end
    return true
end

function Tetronimo:hardDrop()
end

function Tetronimo:isPlaced()
end