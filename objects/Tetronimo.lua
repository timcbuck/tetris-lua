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
    self.orientation = 1 -- 1=up, 2=right, 3=down, 4=left
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
    for _, block in ipairs(self.form) do
        love.graphics.rectangle("fill",
                                Globals.PLAY_AREA_TOP_LEFT_X + (self.block_size * block.x) + (self.block_size * self.x_offset),
                                Globals.PLAY_AREA_TOP_LEFT_Y + (self.block_size * block.y) + (self.block_size * self.y_offset),
                                self.block_size,
                                self.block_size)
    end
end

function Tetronimo:rotate()
    if input:pressed("rotate") then
        if self.form then -- self.form is defined in subclass, so it will be nil briefly when object first created
            local rotation_x, rotation_y = self:getRotationPoint()
            for _, block in ipairs(self.form) do
                local new_x, new_y
                
                if not block.rotation_point then
                    -- TODO: rotate by 2 places for blocks further from rotation point???
                    local x_diff = block.x - rotation_x
                    local y_diff = block.y - rotation_y

                    if (block.x == rotation_x and block.y < rotation_y) or block.x < rotation_x then new_x = block.x + 1 end
                    if (block.x == rotation_x and block.y > rotation_y) or block.x > rotation_x then new_x = block.x - 1 end
                    if (block.y == rotation_y and block.x < rotation_x) or block.y > rotation_y then new_y = block.y - 1 end
                    if (block.y == rotation_y and block.x > rotation_x) or block.y < rotation_y then new_y = block.y + 1 end

                    
                    if self:canRotate(new_x, new_y, self.x_offset, self.y_offset) then
                        block.x = new_x or block.x
                        block.y = new_y or block.y
                    end
                end
            end
        end
    end
end

function Tetronimo:move()
    if input:down("right", Globals.move_speed) then
        if self:canMove(self.x_offset + 1, self.y_offset) then self.x_offset = self.x_offset + 1 end
    end
    if input:down("left", Globals.move_speed) then
        if self:canMove(self.x_offset - 1, self.y_offset) then self.x_offset = self.x_offset - 1 end
    end
end

function Tetronimo:fall()
    local new_y_offset = self.y_offset + 1
    -- TODO: check if it can move down
    if self:canMove(self.x_offset, self.y_offset + 1) then self.y_offset = self.y_offset + 1 end
end

function Tetronimo:canMove(new_x_offset, new_y_offset)
    if self.form then -- self.form is defined in subclass, so it will be nil briefly when object first created
        for _, block in ipairs(self.form) do
            if block.x + new_x_offset > 9 or block.x + new_x_offset < 0 then return false end
            if block.y + new_y_offset > 19 then return false end
            -- TODO: Block is going to overlap another block in the matrix
        end
    end
    return true
end

function Tetronimo:canRotate(new_x, new_y, x_off, y_off)
    if new_x + x_off < 0 or new_x + x_off > 9 then return false end
    if new_y + y_off > 19 then return false end
    return true
end

function Tetronimo:getRotationPoint()
    if self.form then
        for _, block in ipairs(self.form) do
            if block.rotation_point then return block.x, block.y end
        end
    end
end