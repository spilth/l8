require 'spec_helper'

module L8
  describe Smartlight do
    let(:serial_port) { double(:serial_port) }

    before(:each) do
      allow(Serial).to receive(:new).with('serial_port') { serial_port }
      allow(Kernel).to receive(:at_exit) do |&block|
        block.call
      end
      allow(serial_port).to receive(:close)
    end

    describe 'deconstruction' do
      it 'closes serial port connection on exit' do
        L8::Smartlight.new('serial_port')

        expect(serial_port).to have_received(:close)
      end
    end

    describe '#set_led' do
      it 'sets the color of the LED at given location' do
        allow(Util).to receive(:frame).with([Smartlight::CMD_L8_LED_SET, 3, 0, 15, 15, 15, 0]) { 'foo'}
        allow(serial_port).to receive(:write).with('foo')

        l8 = L8::Smartlight.new('serial_port')
        l8.set_led(3, 0, 15, 15, 15)
      end
    end

    describe '#set_orientation' do
      before(:each) do
        allow(serial_port).to receive(:write).with('foo')
      end

      describe 'to up' do
        it 'sends 0x80 with 1' do
          expect(Util).to receive(:frame).with([Smartlight::CMD_L8_SET_ORIENTATION, 1]) { 'foo'}

          l8 = L8::Smartlight.new('serial_port')
          l8.set_orientation(:up)
        end
      end

      describe 'to down' do
        it 'sends 0x80 with 2' do
          expect(Util).to receive(:frame).with([Smartlight::CMD_L8_SET_ORIENTATION, 2]) { 'foo'}

          l8 = L8::Smartlight.new('serial_port')
          l8.set_orientation(:down)
        end
      end

      describe 'to right' do
        it 'sends 0x80 with 5' do
          expect(Util).to receive(:frame).with([Smartlight::CMD_L8_SET_ORIENTATION, 5]) { 'foo'}

          l8 = L8::Smartlight.new('serial_port')
          l8.set_orientation(:right)
        end
      end

      describe 'to left' do
        it 'sends 0x80 with 6' do
          expect(Util).to receive(:frame).with([Smartlight::CMD_L8_SET_ORIENTATION, 6]) { 'foo'}

          l8 = L8::Smartlight.new('serial_port')
          l8.set_orientation(:left)
        end
      end
    end
  end
end
