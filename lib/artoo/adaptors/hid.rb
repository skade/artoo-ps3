require 'artoo/adaptors/adaptor'

module Artoo
  module Adaptors

    class Hid < Adaptor
      attr_reader :device, :vendor_id, :device_id

      # Creates connection with hid device
      # @return [Boolean]
      def connect
        require 'javahidapi' unless defined?(::Javahidapi)
        begin
          vendor_id, device_id, serial = @port.port.split(":").map { |s| s.to_i if s }
          @device = Javahidapi.manager.openById(vendor_id, device_id, serial)
          @connected = true
        rescue com.codeminders.hidapi.HIDDeviceNotFoundException
          warn("could not find connected controller")
          @connected = false
        end
      end

      # Closes connection with HID device
      # @return [Boolean]
      def disconnect
        device.close
      end

      def method_missing(method_name, *arguments, &block)
        device.send(method_name, *arguments, &block)
      end
    end
  end
end