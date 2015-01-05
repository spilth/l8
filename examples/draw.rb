require 'l8'
require 'io/console'

@l8 = L8::Smartlight.new("/dev/tty.usbmodem1411")

@x = 0
@y = 0

def read_char
  STDIN.echo = false
  STDIN.raw!

  input = STDIN.getc.chr
  if input == "\e" then
    input << STDIN.read_nonblock(3) rescue nil
    input << STDIN.read_nonblock(2) rescue nil
  end
ensure
  STDIN.echo = true
  STDIN.cooked!

  return input
end

def show_single_key
  c = read_char

  @l8.set_led(@x,@y, 15,15,15)

  case c
    when " "
      puts "SPACE"
    when "\e[A"
      # up
      @x = @x - 1
    when "\e[B"
      # up
      @x = @x + 1
    when "\e[C"
      # right
      @y = @y + 1
    when "\e[D"
      # left
      @y = @y - 1
    when "\u0003"
      puts "CONTROL-C"
      exit 0
    else
      puts "SOMETHING ELSE: #{c.inspect}"
  end

  @l8.set_led(@x,@y, 0,15,0)
end

@l8.clear_matrix

@l8.set_led(@x,@y, 0,15,0)

show_single_key while(true)
