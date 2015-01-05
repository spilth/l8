require 'l8'
require 'rest_client'
require 'json'

def pending(index)
  @l8.set_led(0, index, 3, 3, 0)
end

def success(index)
  @l8.set_led(0, index, 0, 15, 0)
end

def failure(index)
  @l8.set_led(0, index, 15, 0, 0)
  @l8.set_superled(15,0,0)
end

def fill_timer
  (0..7).each { |i| @l8.set_led(7, i, 1, 1, 1) }
end

def waiting_progress
  (0..7).each do |i|
    sleep 8
    @l8.set_led(7, 7 - i, 0, 0, 0)
  end
end

def get_status(url)
  response = RestClient.get url
  json = JSON.parse(response)
  json[0]['result']
end

@l8 = L8::Smartlight.new('/dev/tty.usbmodem1411')

@projects = %w(
  https://api.travis-ci.org/repos/pivotal/pivotal-life/builds
  https://api.travis-ci.org/repos/spilth/little_bits/builds
  https://api.travis-ci.org/repositories/rdkit/rdkit/builds
  https://api.travis-ci.org/repos/spilth/wedderdotcom/builds
  https://api.travis-ci.org/repos/spilth/ubyray/builds
  https://api.travis-ci.org/repos/spilth/littlebits-travis-webhook/builds
  https://api.travis-ci.org/repos/sir-dunxalot/ember-flash-messages/builds
)

@l8.clear_matrix

while true
  @l8.set_superled(0,15,0)
  @projects.each_with_index do |url, index|
    pending(index)

    if get_status(url) == 0
      success(index)
    else
      failure(index)
    end
  end

  fill_timer

  waiting_progress
end


