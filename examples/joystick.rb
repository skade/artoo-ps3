require 'artoo'
require 'javahidapi' #not strictly necessary, but it gives us the vendor IDS

connection :hid, :adaptor => :hid, :port => "#{Javahidapi::VendorIDs::SONY}:#{Javahidapi::ProductIDs::PS3_CONTROLLER
}"
device :controller, :driver => :ps3_controller, :interval => 0.1

work do
  on controller, :right_joystick => proc { |event, value|
    puts value
  }
  on controller, :cross => proc { |event, down, pressed|
    puts [event, down, pressed].inspect
  }
end
