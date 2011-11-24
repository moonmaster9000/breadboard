module ActiveResource
  class Base
    class << self
      class_eval do
        %w(site user password).each do |attr|
          define_method "#{attr}_with_breadboard" do
            @site || begin
              setting = Breadboard.service_for(self)
              setting.kind_of?(Hash) ? setting[attr.to_sym] : setting
            end
          end
          alias_method_chain attr, :breadboard
        end
      end

      def connection_with_breadboard(reset=false)
        @connection ||= nil
        connection_without_breadboard(reset)
      end
      alias_method_chain :connection, :breadboard
    end
  end
end
