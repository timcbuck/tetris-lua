Object = require("libraries.classic")
Input = require("libraries.input")
Timer = require("libraries.timer")
Globals = require("globals")


function love.load()
    love.window.setTitle("TETRIS")
    love.window.setMode(Globals.WINDOW_WIDTH, Globals.WINDOW_HEIGHT)

    input = Input()
    input:bind("a", "left")
    input:bind("d", "right")
    input:bind("s", "down")
    input:bind("space", "rotate")

    timer = Timer()

    states = {}
    states.start = require("states.start")
    states.game = require("states.game")
    current_state = nil
    changeState("start")
end

function love.update(dt)
    if current_state and current_state.update then
        current_state.update(dt)
    end
end

function love.draw()
    if current_state and current_state.draw then
        current_state.draw()
    end
end

function love.keypressed(key)
    if key == "return" and current_state == states.start then
        current_state = states.game
        current_state.load()
    elseif key == "escape" then
        love.event.quit()
    elseif current_state and current_state.keypressed then -- handle keypressed in other states
       current_state.keypressed(key)
    end
end

function changeState(newState)
    current_state = states[newState]
end