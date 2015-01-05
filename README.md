[![Build Status](https://travis-ci.org/spilth/l8.svg?branch=master)](https://travis-ci.org/spilth/l8)

# L8

A gem for communicating with an [L8 SmartLight](http://l8smartlight.com) over USB.

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

To connect to your L8 Smartlight, determine the serial port it's on:

    require 'l8'
    l8 = L8::Smartlight.new('/dev/tty.usbmodem1421')

### Changing LEDs

Use `set_led` to set one of the LEDs to a color.  The arguments are:

  - x coordinate of the LED (0..7)
  - y coordinate of the LED (0..7)
  - red color value (0..15)
  - green color value (0..15)
  - blue color values (0..15)

For example, to set the 5th LED in the 3rd row to orange:

    l8.set_led(2, 4 ,15, 7, 0)

### Clearing the LEDs

Use the `clear_matrix` method:

    l8.clear_matrix

### Changing the Super (Back) LED

Use the `set_superled` method and pass 3 color values (0..15):

    l8.set_superled(0, 0, 15)

## Contributing

1. Fork it ( https://github.com/spilth/l8/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
