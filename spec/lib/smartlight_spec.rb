require 'spec_helper'

module L8
  describe Smartlight do
    let(:serial_port) { double(:serial_port) }
    describe '#set_led' do
      it 'sets the color of the LED at given location' do
        allow(Serial).to receive(:new).with('serial_port') { serial_port }
        allow(serial_port).to receive(:write).with("\xaa\x55\x07\x03\x00\x0F\x0F\x0F\x00\x0E")

        l8 = L8::Smartlight.new('serial_port')
        l8.set_led(3, 0, 15, 15, 15)
      end
    end
  end
end
