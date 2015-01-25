require 'spec_helper'

module L8
  describe Smartlight do
    let(:serial_port) { double(:serial_port) }
    let(:frame) { double(:frame) }

    before(:each) do
      allow(Serial).to receive(:new).with('serial_port') { serial_port }
      allow(Kernel).to receive(:at_exit) do |&block|
        block.call
      end
      allow(serial_port).to receive(:write).with(frame)
      allow(serial_port).to receive(:read).with(6)
      allow(serial_port).to receive(:close)
    end

    describe 'deconstruction' do
      it 'closes serial port connection on exit' do
        L8::Smartlight.new('serial_port')

        expect(serial_port).to have_received(:close)
      end
    end

    describe '#clear_matrix' do
      it 'sends a command to clear the matrix' do
        expect(Frame).to receive(:new).with([Smartlight::CMD_L8_MATRIX_OFF]) { frame }

        l8 = L8::Smartlight.new('serial_port')
        l8.clear_matrix
      end
    end

    describe '#set_led' do
      it 'sets the color of the LED at given location with 1-based coordinates' do
        expect(Frame).to receive(:new).with([Smartlight::CMD_L8_LED_SET, 3, 0, 15, 15, 15, 0]) { frame }

        l8 = L8::Smartlight.new('serial_port')
        l8.set_led(3, 0, 15, 15, 15)
      end
    end

    describe '#set_superled' do
      it 'sets the color of the superled' do
        expect(Frame).to receive(:new).with([Smartlight::CMD_L8_SUPERLED_SET, 15, 14, 13]) { frame }

        l8 = L8::Smartlight.new('serial_port')
        l8.set_superled(13, 14, 15)
      end
    end

    describe '#display_character' do
      it 'display a single character on the L8' do
        expect(Frame).to receive(:new).with([Smartlight::CMD_L8_DISP_CHAR, 66, 0]) { frame }

        l8 = L8::Smartlight.new('serial_port')
        l8.display_character('B')
      end
    end

    describe '#enable_status_leds' do
      it 'enables the status LEDs' do
        expect(Frame).to receive(:new).with([Smartlight::CMD_L8_STATUSLEDS_ENABLE, 1]) { frame }

        l8 = L8::Smartlight.new('serial_port')
        l8.enable_status_leds
      end
    end

    describe '#disable_status_leds' do
      it 'disables the status LEDs' do
        expect(Frame).to receive(:new).with([Smartlight::CMD_L8_STATUSLEDS_ENABLE, 0]) { frame }

        l8 = L8::Smartlight.new('serial_port')
        l8.disable_status_leds
      end
    end

    describe '#set_brightness' do
      describe 'to low' do
        it 'sets it to low' do
          expect(Frame).to receive(:new).with([Smartlight::CMD_L8_SET_LOW_BRIGHTNESS, 2]) { frame }

          l8 = L8::Smartlight.new('serial_port')
          l8.set_brightness(:low)
        end
      end

      describe 'to medium' do
        it 'sets it to medium' do
          expect(Frame).to receive(:new).with([Smartlight::CMD_L8_SET_LOW_BRIGHTNESS, 1]) { frame }

          l8 = L8::Smartlight.new('serial_port')
          l8.set_brightness(:medium)
        end
      end

      describe 'to high' do
        it 'sets it to high' do
          expect(Frame).to receive(:new).with([Smartlight::CMD_L8_SET_LOW_BRIGHTNESS, 0]) { frame }

          l8 = L8::Smartlight.new('serial_port')
          l8.set_brightness(:high)
        end
      end
    end

    describe '#power_off' do
      it 'sends the poweroff message' do
        expect(Frame).to receive(:new).with([Smartlight::CMD_L8_POWEROFF]) { frame }

        l8 = L8::Smartlight.new('serial_port')
        l8.power_off
      end
    end

    describe '#set_orientation' do
      before(:each) do
        allow(serial_port).to receive(:write).with(frame)
      end

      describe 'to up' do
        it 'sends 0x80 with 1' do
          expect(Frame).to receive(:new).with([Smartlight::CMD_L8_SET_ORIENTATION, 1]) { frame }

          l8 = L8::Smartlight.new('serial_port')
          l8.set_orientation(:up)
        end
      end

      describe 'to down' do
        it 'sends 0x80 with 2' do
          expect(Frame).to receive(:new).with([Smartlight::CMD_L8_SET_ORIENTATION, 2]) { frame }

          l8 = L8::Smartlight.new('serial_port')
          l8.set_orientation(:down)
        end
      end

      describe 'to right' do
        it 'sends 0x80 with 5' do
          expect(Frame).to receive(:new).with([Smartlight::CMD_L8_SET_ORIENTATION, 5]) { frame }

          l8 = L8::Smartlight.new('serial_port')
          l8.set_orientation(:right)
        end
      end

      describe 'to left' do
        it 'sends 0x80 with 6' do
          expect(Frame).to receive(:new).with([Smartlight::CMD_L8_SET_ORIENTATION, 6]) { frame }

          l8 = L8::Smartlight.new('serial_port')
          l8.set_orientation(:left)
        end
      end
    end
  end
end
