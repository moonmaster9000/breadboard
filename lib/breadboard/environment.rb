module Breadboard
  module Config
    class Environment
      def initialize
        @environments = {}
      end

      def test(url=nil)
        return @environments[:test] if url.nil?
        @environments[:test] = URI.parse url
      end

      def method_missing(method_name, *args, &block)
        return @environments[method_name] if args.length == 0
        param = args.first
        if param.kind_of?(Hash)
          @environments[method_name] = param
        else
          @environments[method_name] = URI.parse param
        end
      end
    end
  end
end
