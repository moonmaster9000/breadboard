module Breadboard
  module Config
    # holds site, user, password values for an environment instance
    class EnvConfig
      def initialize
        @config = {}
      end

      def site=(url)
        @config[:site] = url
      end

      def method_missing(method_name, *args, &block)
        return @config[method_name] if args.length == 0
        @config[method_name] = args.first
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

