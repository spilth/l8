require 'l8'
require 'sdl'

SDL.init(SDL::INIT_JOYSTICK)
@joystick = SDL::Joystick.open(0)

@x = 0
@y = 0

@l8 = L8::Smartlight.new("/dev/tty.usbmodem1411")
@l8.clear_matrix
@l8.disable_status_leds
@l8.set_brightness(:low)
@l8.set_superled(0,0,0)
@l8.set_led(@x,@y, 15, 15, 15)

@colors = [
    [14,0,0],
    [0,14,0],
    [0,0,14],
    [14,14,14],
    [0,0,0]
]
@color_index = 0

def read_joystick
  SDL::Joystick.update_all

  @color_index = @color_index + 1 if @joystick.button(1)
  @color_index = @color_index - 1 if @joystick.button(2)

  @color_index = 0 if @color_index > 4
  @color_index = 4 if @color_index < 0

  color = @colors[@color_index]
  @l8.set_led(@y,@x, color[0], color[1], color[2])

  @l8.set_superled(color[0], color[1], color[2]) if @joystick.button(8)

  @x = @x - 1 if @joystick.axis(3) < -16384
  @x = @x + 1 if @joystick.axis(3) > 16384
  @y = @y - 1 if @joystick.axis(4) < -16384
  @y = @y + 1 if @joystick.axis(4) > 16384

  @x = 0 if @x < 0
  @y = 0 if @y < 0
  @x = 7 if @x > 7
  @y = 7 if @y > 7

  @l8.set_led(@y,@x, color[0] + 1, color[1] + 1, color[2] + 1)

  @l8.clear_matrix if @joystick.button(9)
  sleep 0.2
end

read_joystick while(true)
