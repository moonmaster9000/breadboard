module ActiveResource
  class Base
    class << self
      def site_with_breadboard
        @site || Breadboard.service_for(self)
      end

      def connection_with_breadboard(reset=false)
        @connection ||= nil
        connection_without_breadboard(reset)
      end

      alias_method_chain :site, :breadboard
      alias_method_chain :connection, :breadboard
    end
  end
end
