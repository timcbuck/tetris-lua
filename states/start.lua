local start = {}

function start.update(dt)
    -- Possibly animate title, etc.
end

function start.draw()
    love.graphics.printf("Press Enter to Start", 0, 200, Globals.WINDOW_WIDTH, "center")
end

function start.keypressed(key)
    if key == "return" then
        -- Change to the game state
        changeState(states.game)
    end
end

return start