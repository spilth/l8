module L8
  class Stack
    def initialize(*ports)
      @l8s = []

      ports.each do |port|
        @l8s << L8::Smartlight.new(port)
      end
    end

    def set_led(x,y,r,g,b)
      l8index = x / 8
      x = x - (l8index * 8)
      @l8s[l8index].set_led(x,y,r,g,b)
    end
  end
end