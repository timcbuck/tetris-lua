local Globals = {}

Globals.WINDOW_WIDTH = 960
Globals.WINDOW_HEIGHT = 800
Globals.BLOCK_SIZE = 32
Globals.PLAY_AREA_TOP_LEFT_X = Globals.WINDOW_WIDTH/2 - (Globals.BLOCK_SIZE * 10 / 2)
Globals.PLAY_AREA_TOP_LEFT_Y = Globals.WINDOW_HEIGHT/2 - (Globals.BLOCK_SIZE * 20 / 2)
Globals.fall_speed = 1 -- seconds
Globals.fall_timer = Timer()
Globals.move_speed = 0.15 -- seconds

return Globals