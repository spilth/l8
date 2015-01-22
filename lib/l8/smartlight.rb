require 'rubyserial'

module L8
  class Smartlight
    CMD_L8_LED_SET = 0x43
    CMD_L8_MATRIX_OFF = 0x45
    CMD_L8_SUPERLED_SET = 0x4b
    CMD_L8_STATUSLEDS_ENABLE = 0x9e
    CMD_L8_SET_LOW_BRIGHTNESS = 0x9a
    CMD_L8_POWEROFF = 0x9d
    CMD_L8_MATRIX_SET = 0x44
    CMD_L8_SET_ORIENTATION = 0x80
    CMD_L8_DISP_CHAR = 0x7f

    def initialize(serial_port)
      @serial_port = Serial.new(serial_port)

      Kernel.at_exit { @serial_port.close }
    end

    def clear_matrix
      @serial_port.write Util.frame([CMD_L8_MATRIX_OFF])
    end

    def set_led(x, y, r, g, b)
      payload = [CMD_L8_LED_SET, x, y, b, g, r, 0x00]

      @serial_port.write Util.frame(payload)
    end

    def set_superled(r,g,b)
      payload = [CMD_L8_SUPERLED_SET, b, g, r]

      @serial_port.write Util.frame(payload)
    end

    def display_character(character)
      payload = [CMD_L8_DISP_CHAR, character.bytes[0], 0]

      @serial_port.write Util.frame(payload)
    end

    def enable_status_leds
      payload = [CMD_L8_STATUSLEDS_ENABLE, 1]

      @serial_port.write Util.frame(payload)
    end

    def disable_status_leds
      payload = [CMD_L8_STATUSLEDS_ENABLE, 0]

      @serial_port.write Util.frame(payload)
    end

    def set_brightness(level)
      brightness = 0

      if level == :low
        brightness = 2
      elsif level == :medium
        brightness = 1
      end

      payload = [CMD_L8_SET_LOW_BRIGHTNESS, brightness]

      @serial_port.write Util.frame(payload)
    end

    def power_off
      @serial_port.write Util.frame([CMD_L8_POWEROFF])
    end

    def set_matrix(pixels)
      data = Util.pixels_to_two_byte_array(pixels)

      payload = [CMD_L8_MATRIX_SET] + data

      @serial_port.write Util.frame(payload)
    end

    def set_orientation(orientation)
      value = 1 if orientation == :up
      value = 2 if orientation == :down
      value = 5 if orientation == :right
      value = 6 if orientation == :left

      payload = [CMD_L8_SET_ORIENTATION, value]
      @serial_port.write Util.frame(payload)
    end
  end
end