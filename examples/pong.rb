require 'l8'

row = L8::Row.new('/dev/tty.usbmodem1421', '/dev/tty.usbmodem1411')
row.clear_matrix
row.disable_status_leds

sleep 1

# red paddle

(2..4).each do |x|
  row.set_led(x, 0, 15, 0, 0)
end

# blue paddle

(3..5).each do |x|
  row.set_led(x, 15, 0, 0, 15)
end

# ball

row.set_led(3, 4, 15, 15, 15)

# red score

(4..6).each do |x|
  row.set_led(0, x, 1, 0, 0)
end

# blue score

(9..13).each do |x|
  row.set_led(0, x, 0, 0, 1)
end

# divider

(0..7).step(2) do |x|
  row.set_led(x, 7, 1, 1, 1)
  row.set_led(x + 1, 8, 1, 1, 1)
end

sleep 2