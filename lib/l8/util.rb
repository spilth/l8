require 'digest/crc8'

module L8
  class Util
    def self.to_two_byte_color(r, g, b)
      [(0.to_s(16) + b.to_s(16)).hex] + [(g.to_s(16) + r.to_s(16)).hex]
      end

    def self.pixels_to_two_byte_array(pixels)
      data = []
      pixels.each_slice(3) { |slice| data.concat to_two_byte_color(slice[0], slice[1], slice[2]) }
      data
    end
  end
end