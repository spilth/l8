require 'spec_helper'

module L8
  describe Util do
    describe '.to_two_byte_color' do
      it 'converts rgb values into two byte format (0x0BGR)' do
        expect(Util.to_two_byte_color(15,15,15)).to eq([15, 255])
        expect(Util.to_two_byte_color(0,0,0)).to eq([0,0])
      end
    end

    describe '.pixel_array_to_two_byte_array' do
      it 'returns an array of two byte pairs' do
        expect(Util.pixels_to_two_byte_array([0,0,0])).to eq([0, 0])
        expect(Util.pixels_to_two_byte_array([0,15,0])).to eq([0, 240])
        expect(Util.pixels_to_two_byte_array([15,15,15])).to eq([15, 255])

        expect(Util.pixels_to_two_byte_array([0,0,0,0,0,0])).to eq([0, 0, 0 ,0])
        expect(Util.pixels_to_two_byte_array([15,15,15, 15, 15, 15])).to eq([15, 255, 15, 255])
      end
    end

    describe '.frame' do
      it 'converts the payload into a checksummed frame' do
        expect(Util.frame([0x43, 0x03, 0x00, 0x0f, 0x0f, 0x0f, 0x00])).to eq("\xaa\x55\x07\x43\x03\x00\x0f\x0f\x0f\x00\x0e".b)
      end
    end
  end
end
