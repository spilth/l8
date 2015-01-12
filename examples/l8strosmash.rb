require 'l8'

stack = L8::Stack.new('/dev/tty.usbmodem1411', '/dev/tty.usbmodem1421')
stack.clear_matrix

sleep 0.2

# ground

(0..7).each do |y|
  stack.set_led(15, y, 0, 7, 0)
end

# ship

stack.set_led(14, 0, 15, 15, 15)
stack.set_led(14, 1, 15, 15, 15)
stack.set_led(14, 2, 15, 15, 15)
stack.set_led(13, 1, 15, 15, 15)

# stars

stack.set_led(1, 6, 1, 1, 1)
stack.set_led(3, 2, 1, 1, 1)
stack.set_led(6, 5, 1, 1, 1)
stack.set_led(8, 2, 1, 1, 1)
stack.set_led(10, 6, 1, 1, 1)

# asteroids

stack.set_led(1,1, 15, 7, 0)
stack.set_led(1,2, 15, 7, 0)
stack.set_led(2,1, 15, 7, 0)
stack.set_led(2,2, 15, 7, 0)

stack.set_led(4,6, 15, 0, 15)
stack.set_led(4,7, 15, 0, 15)
stack.set_led(5,6, 15, 0, 15)
stack.set_led(5,7, 15, 0, 15)

stack.set_led(9, 4, 15, 15, 0)
stack.set_led(9, 5, 15, 15, 0)
stack.set_led(10, 4, 15, 15, 0)
stack.set_led(10, 5, 15, 15, 0)

sleep 2