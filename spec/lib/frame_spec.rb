require 'spec_helper'

module L8
  describe Frame do
    describe '.to_s' do
      it 'converts the payload into a checksummed frame' do
        frame = Frame.new([0x43, 0x03, 0x00, 0x0f, 0x0f, 0x0f, 0x00])
        expect(frame.to_s).to eq "\xaa\x55\x07\x43\x03\x00\x0f\x0f\x0f\x00\x0e".b
      end
    end
  end
end
