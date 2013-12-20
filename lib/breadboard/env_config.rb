module Breadboard
  module Config
    # holds site, user, password values for an environment instance
    class EnvConfig
      def site(url=nil)
        if url
          @site = url
        else
          return @site if @site.kind_of?(URI)

          if @site
            if @site.respond_to? :call
              URI.parse @site.call
            else
              URI.parse @site
            end
          end
        end
      end

      def user(username=nil)
        return @user unless username
        @user = username
      end

      def password(pass=nil)
        return @password unless pass
        @password = pass
      end

      def to_s
        @site.to_s
      end

      def empty?
        !(site || password || user)
      end
    end
  end
end

