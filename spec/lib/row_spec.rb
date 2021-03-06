require 'spec_helper'

module L8
  describe Row do
    describe '#set_led' do
      describe 'when there are three L8s in the stack' do
        let(:light1) { double(:l8one) }
        let(:light2) { double(:l8two) }
        let(:light3) { double(:l8three) }

        before(:each) do
          allow(L8::Smartlight).to receive(:new).with('/dev/foo') { light1 }
          allow(L8::Smartlight).to receive(:new).with('/dev/bar') { light2 }
          allow(L8::Smartlight).to receive(:new).with('/dev/baz') { light3 }
        end

        describe 'when the pixel is within the range of the first L8' do
          it 'turns on an led on the first L8' do
            expect(light1).to receive(:set_led).with(7,7,15,15,15)

            l8stack = L8::Row.new('/dev/foo', '/dev/bar')
            l8stack.set_led(7,7,15,15,15)
          end
        end

        describe 'when the pixel is outside the range of the first L8' do
          it 'turns on an LED on the second L8' do
            expect(light2).to receive(:set_led).with(0,0,15,15,15)

            l8stack = L8::Row.new('/dev/foo', '/dev/bar')
            l8stack.set_led(0,8,15,15,15)
          end
        end

        describe 'when the pixel is outside the range of the first and second L8' do
          it 'turns on an LED on the third L8' do
            expect(light3).to receive(:set_led).with(0,0,15,15,15)

            l8stack = L8::Row.new('/dev/foo', '/dev/bar', '/dev/baz')
            l8stack.set_led(0,16,15,15,15)
          end
        end
      end
    end
  end
end