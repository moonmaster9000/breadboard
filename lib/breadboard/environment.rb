module Breadboard
  module Config
    class Environment
      def initialize
        @environments = {}
      end

      def method_missing(method_name, *args, &block)
        return @environments[method_name] if args.length == 0
        @environments[method_name] = args.first 
      end
    end
  end
end
