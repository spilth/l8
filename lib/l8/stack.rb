module L8
  class Stack < Group
    def set_led(x,y,r,g,b)
      l8index = x / 8
      x = x - (l8index * 8)
      @l8s[l8index].set_led(x,y,r,g,b)
    end
  end
end