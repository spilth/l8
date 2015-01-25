require 'rubyserial'

module L8
  class Smartlight
    CMD_L8_DISP_CHAR = 0x7f
    CMD_L8_LED_SET = 0x43
    CMD_L8_MATRIX_OFF = 0x45
    CMD_L8_MATRIX_SET = 0x44
    CMD_L8_POWEROFF = 0x9d
    CMD_L8_SET_LOW_BRIGHTNESS = 0x9a
    CMD_L8_SET_ORIENTATION = 0x80
    CMD_L8_STATUSLEDS_ENABLE = 0x9e
    CMD_L8_SUPERLED_SET = 0x4b

    def initialize(serial_port)
      @serial_port = Serial.new(serial_port)

      Kernel.at_exit { @serial_port.close }
    end

    def clear_matrix
      send_command [CMD_L8_MATRIX_OFF]
    end

    def set_led(x, y, r, g, b)
      send_command [CMD_L8_LED_SET, x, y, b, g, r, 0x00]
    end

    def set_superled(r,g,b)
      send_command [CMD_L8_SUPERLED_SET, b, g, r]
    end

    def display_character(character)
      send_command [CMD_L8_DISP_CHAR, character.bytes[0], 0]
    end

    def enable_status_leds
      send_command [CMD_L8_STATUSLEDS_ENABLE, 1]
    end

    def disable_status_leds
      send_command [CMD_L8_STATUSLEDS_ENABLE, 0]
    end

    def set_brightness(level)
      brightness = 0
      brightness = 2 if level == :low
      brightness = 1 if level == :medium

      send_command [CMD_L8_SET_LOW_BRIGHTNESS, brightness]
    end

    def power_off
      send_command [CMD_L8_POWEROFF]
    end

    def set_matrix(pixels)
      data = Util.pixels_to_two_byte_array(pixels)

      send_command [CMD_L8_MATRIX_SET] + data
    end

    def set_orientation(orientation)
      value = 1
      value = 2 if orientation == :down
      value = 5 if orientation == :right
      value = 6 if orientation == :left

      send_command [CMD_L8_SET_ORIENTATION, value]
    end

    private

    def send_command payload
      frame = Frame.new(payload)
      @serial_port.write frame
      result = @serial_port.read(6)
      while (result == '') do
        result = @serial_port.read(6)
      end
    end
  end
end