module Breadboard
  module Config
    # holds site, user, password values for an environment instance
    class EnvConfig
      def initialize
        @config = {}
      end

      def method_missing(method_name, *args, &block)
        return @config[method_name] if args.length == 0

        val = args.first
        if method_name == :site and val.kind_of?(String)
          val = URI.parse(val)
        end
        @config[method_name] = val
      end

      def to_s
        @config[:site].to_s
      end

      def empty?
        @config.empty?
      end
    end
  end
end

