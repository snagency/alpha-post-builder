module AlphaPostBuilder
  class TwitterBuilder < BaseBuilder
    def user_attributes
      {
        uid:              data[:user][:screen_name],  # uid = screen_name  Это нормально!!
        name:             data[:user][:name],
        screen_name:      data[:user][:id].to_s, # screen_name = uid  Это нормально!!
        image:            data[:user][:profile_image_url],
        location:         data[:user][:location].empty? ? nil : data[:user][:location],
        url:              data[:user][:url],
        friends_count:    data[:user][:friends_count],
        followers_count:  data[:user][:followers_count]
      }
    end

    def post_attributes
      {
        created_time: created_at,
        title:        nil,
        text:         data[:text],
        post_id:      data[:id].to_s,
        location:     location,
        url:          data[:url],
        media_type:   image_url ? 'image' : nil,
        image_url:    image_url,
      }
    end

    private

    def image_url
      @image_url ||= begin
        media = data[:entities].try(:[],:media)
        return unless media && media.any?
        media.first[:media_url].to_s
      end
    end

    def location
      if data[:coordinates]
        "#{data[:place].try(:[],:full_name)} (#{data[:coordinates][:coordinates].join(',')})"
      elsif data[:user][:location]
        data[:user][:location]
      end
    end

    def created_at
      if data[:created_at].to_i.to_s == data[:created_at]
        data[:created_at].to_i
      else
        begin
          Time.parse(data[:created_at]).to_i
        rescue
          nil
        end
      end
    end
  end
end
