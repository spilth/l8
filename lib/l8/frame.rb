module L8
  class Frame
    HEADER = [0xaa, 0x55]

    def initialize(payload)
      @payload = payload
    end

    def to_s
      crc8 = Digest::CRC8.new
      crc8 << @payload.pack('C*')

      frame = HEADER + [payload.size] + payload << crc8.checksum
      frame.pack('C*')
    end

    private

    attr_reader :payload

  end
end