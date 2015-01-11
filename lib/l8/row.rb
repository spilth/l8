module L8
  class Row
    def initialize(*ports)
      @l8s = []

      ports.each do |port|
        @l8s << L8::Smartlight.new(port)
      end
    end

    def set_led(x,y,r,g,b)
      l8index = y / 8
      y = y - (l8index * 8)
      @l8s[l8index].set_led(x,y,r,g,b)
    end

    def clear_matrix
      @l8s.each do |l8|
        l8.clear_matrix
      end
    end
  end
end