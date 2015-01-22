require 'spec_helper'

module L8
  describe Group do
    describe 'constructor' do
      it 'creates a Smartlight instance on each supplied serial port' do
        expect(L8::Smartlight).to receive(:new).with('/dev/foo') { 'foo' }
        expect(L8::Smartlight).to receive(:new).with('/dev/bar') { 'bar' }

        L8::Group.new('/dev/foo', '/dev/bar')
      end
    end

    describe '#clear_matrix' do
      describe 'when there are three L8s in the Group' do
        let(:light1) { double(:l8one) }
        let(:light2) { double(:l8two) }
        let(:light3) { double(:l8three) }

        before(:each) do
          allow(L8::Smartlight).to receive(:new).with('/dev/foo') { light1 }
          allow(L8::Smartlight).to receive(:new).with('/dev/bar') { light2 }
          allow(L8::Smartlight).to receive(:new).with('/dev/baz') { light3 }
        end

        it 'calls clear_matrix on each light' do
          expect(light1).to receive(:clear_matrix)
          expect(light2).to receive(:clear_matrix)
          expect(light3).to receive(:clear_matrix)

          l8Group = L8::Group.new('/dev/foo', '/dev/bar', '/dev/baz')
          l8Group.clear_matrix
        end
      end
    end

    describe '#disable_status_lights' do
      describe 'when there are three L8s in the Group' do
        let(:light1) { double(:l8one) }
        let(:light2) { double(:l8two) }
        let(:light3) { double(:l8three) }

        before(:each) do
          allow(L8::Smartlight).to receive(:new).with('/dev/foo') { light1 }
          allow(L8::Smartlight).to receive(:new).with('/dev/bar') { light2 }
          allow(L8::Smartlight).to receive(:new).with('/dev/baz') { light3 }
        end

        it 'calls disable_status_lights on each light' do
          expect(light1).to receive(:disable_status_leds)
          expect(light2).to receive(:disable_status_leds)
          expect(light3).to receive(:disable_status_leds)

          l8Group = L8::Group.new('/dev/foo', '/dev/bar', '/dev/baz')
          l8Group.disable_status_leds
        end
      end
    end
  end
end