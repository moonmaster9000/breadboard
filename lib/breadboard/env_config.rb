module Breadboard
  module Config
    # holds site, user, password values for an environment instance
    class EnvConfig
      def site(url=nil)
        return @site unless url
        
        if url.kind_of?(URI)
          @site = url
        else
          @site = URI.parse url
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

