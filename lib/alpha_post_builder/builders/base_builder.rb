module AlphaPostBuilder
  class BaseBuilder
    attr_reader :data
    class << self
      def filter(data)
        new(data).filter
      end
    end

    def initialize(data)
      @data = data
    end

    def filter
      {
        user: default_user_attributes.merge(user_attributes),
        post: default_post_attributes.merge(post_attributes)
      }
    end

    def network
      self.class.name.gsub('AlphaPostBuilder::', '').gsub('Builder', '').underscore
    end

    def user_attributes
      raise '#user_attributes should be redefined in a child class'
    end

    def post_attributes
      raise '#post_attributes should be redefined in a child class'
    end

    private

    def default_user_attributes
      {
        location: nil,
        friends_count: 0,
        followers_count: 0,
        screen_name: nil,
        image: nil,
        url: nil
      }
    end

    def default_post_attributes
      {
        title: nil,
        network: network,
        location: nil,
        media_type: nil,
        image_url: nil
      }
    end
  end
end
