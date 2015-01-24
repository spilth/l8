[![Build Status](https://travis-ci.org/spilth/l8.svg?branch=master)](https://travis-ci.org/spilth/l8)

# L8

A Ruby Gem for communicating with an [L8 SmartLight](http://l8smartlight.com) over USB.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'l8'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install l8

## Usage

To connect to your L8 Smartlight, determine the serial port it's on and then create a new L8::Smartlight:

    require 'l8'
    l8 = L8::Smartlight.new('/dev/tty.usbmodem1421')

### Change LEDs

Use `set_led` to set one of the LEDs to a color.  The arguments are:

  - x coordinate of the LED (0..7)
  - y coordinate of the LED (0..7)
  - red color value (0..15)
  - green color value (0..15)
  - blue color values (0..15)

For example, to set the 5th LED in the 3rd row to orange:

    l8.set_led(2, 4, 15, 7, 0)

### Clear the LEDs

Use the `clear_matrix` method:

    l8.clear_matrix

### Change the Super (Back) LED

Use the `set_superled` method and pass 3 color values (0..15):

    l8.set_superled(0, 0, 15)
    
### Set L8 Brightness

You can control the overall brightness of the L8 using the `set_brightness` method with one of the following values: `:high`, `:medium` or `:low`.

    l8.set_brightness(:low)
    
### Disable/Enable Status LEDs

The status LEDs on the top of the L8 can leak light into the LED matrix or just detract from the main LEDs in general, so you can turn them off with the `disable_status_leds` method. There is a `enable_status_leds` method to turn them back on.

    l8.disable_status_leds
    
### Force L8 Orientation

If you lay the L8 flat or move it around a lot it may lose your preferred orienation in reference to the status lights at the top of the L8.

You can force the orientation using the `set_orientation` method and passing one of the following: `:up`, `:down`, `:left` or `:right`.

    l8.set_orientation(:down)

### Display Character

To display an alpha-numeric character on the L8, use the `display_character` method and send a single Ascii character.

    l8.display_character('')

### Power Off

You can turn the L8s off using the `power_off` method.

    l8.power_off
    
### Controlling Groups of L8s

You can control a group of L8s as either a Stack or Row of them. This will give you a `set_led` method that treats them as one big matrix of LEDs.

    stack = L8::Stack.new('/dev/tty.usbmodem1421', '/dev/tty.usbmodem1422')
    stack.set_led(7, 15, 0, 15, 0)
    
The following methods are also available on groups of L8s and affect all L8s in the group.

- `clear_matrix`
- `disable_status_lights`
    
#### Identify L8s in a Group

When using a group of L8s you might get your USB ports/wires crossed and need to figure out the correct order to put the L8s in. The `identify` method will put a number on each L8 letting you know how to arrange them - left to right or top to bottom, start at 1.

## Resources

- [SLCP Specification 1.0](http://www.l8smartlight.com/dev/slcp/1.0/)

## Contributing

1. Fork it ( https://github.com/spilth/l8/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
