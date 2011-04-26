module ActiveResource
  class Base
    class << self
      def site_with_breadboard
        @site ||= Breadboard.service_for(self)
      end

      alias_method_chain :site, :breadboard
    end
  end
end
