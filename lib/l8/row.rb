module L8
  class Row < Group
    def set_led(x,y,r,g,b)
      l8index = y / 8
      y = y - (l8index * 8)
      @l8s[l8index].set_led(x,y,r,g,b)
    end
  end
end