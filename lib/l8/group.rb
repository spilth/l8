module L8
  class Group
    def initialize(*ports)
      @l8s = []

      ports.each do |port|
        @l8s << L8::Smartlight.new(port)
      end
    end

    def disable_status_leds
      @l8s.each do |l8|
        l8.disable_status_leds
      end
    end

    def clear_matrix
      @l8s.each do |l8|
        l8.clear_matrix
      end
    end

    def identify
      @l8s.each_with_index do |l8, index|
        l8.display_character((index + 1).to_s)
      end
    end

  end
end