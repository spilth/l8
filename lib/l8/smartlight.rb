require 'rubyserial'
require 'digest/crc8'

module L8
  class Smartlight
    HEADER = [0xaa, 0x55]
    LED_SET = 0x43
    MATRIX_OFF = 0x45
    SUPERLED_SET = 0x4b

    def initialize(serial_port)
      @serial_port = Serial.new(serial_port)
    end

    def clear_matrix
      @serial_port.write frame([MATRIX_OFF])
    end

    def set_led(x, y, r, g, b)
      payload = [LED_SET, x, y, b, g, r, 0x00]

      @serial_port.write frame(payload)
    end

    def set_superled(r,g,b)
      payload = [SUPERLED_SET, b, g, r]

      @serial_port.write frame(payload)
    end

    private

    def frame(payload)
      crc8 = Digest::CRC8.new
      crc8 << payload.pack('C*')

      frame = HEADER + [payload.size] + payload << crc8.checksum
      frame.pack('C*')
    end
  end
end