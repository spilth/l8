require 'l8'
require 'rest_client'
require 'json'

def pending(column, row)
  @l8.set_led(row, column, 15, 15, 15)
end

def success(column, row)
  if row == 0
    @l8.set_led(row, column, 0, 15, 0)
  else
    @l8.set_led(row, column, 0, 1, 0)
  end
end

def failure(column, row)
  if row  == 0
    @l8.set_led(row, column, 15, 0, 0)
    @l8.set_superled(15,0,0)
  else
    @l8.set_led(row, column, 1, 0, 0)
  end
end

def fill_timer
  (0..7).each { |i| @l8.set_led(7, i, 0, 0, 1 + (i * 2)) }
end

def waiting_progress
  (0..7).each do |i|
    sleep 8
    @l8.set_led(7, 7 - i, 0, 0, 0)
  end
end

def get_statuses(url)
  response = RestClient.get url
  JSON.parse(response)
end

@l8 = L8::Smartlight.new('/dev/tty.usbmodem1411')

@projects = %w(
  https://api.travis-ci.org/repos/spilth/l8/builds
  https://api.travis-ci.org/repos/pivotal/pivotal-life/builds
  https://api.travis-ci.org/repos/spilth/little_bits/builds
  https://api.travis-ci.org/repositories/rdkit/rdkit/builds
  https://api.travis-ci.org/repos/spilth/wedderdotcom/builds
  https://api.travis-ci.org/repos/spilth/ubyray/builds
  https://api.travis-ci.org/repos/spilth/littlebits-travis-webhook/builds
  https://api.travis-ci.org/repos/sir-dunxalot/ember-flash-messages/builds
)

@l8.clear_matrix
@l8.disable_status_leds
@l8.set_brightness(:high)

while true
  @l8.set_superled(0,15,0)

  @projects.each_with_index do |url, column|
    builds = get_statuses(url)

    builds.each_with_index do |build, row|
      if row == 7
        break
      end

      pending(column, row)
      sleep 0.1

      status = build['result']

      if status == 0
        success(column, row)
      else
        failure(column, row)
      end

    end
  end

  fill_timer

  waiting_progress
end


