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
  end
end
