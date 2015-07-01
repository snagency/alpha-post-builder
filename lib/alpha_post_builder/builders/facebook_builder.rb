module AlphaPostBuilder
  class FacebookBuilder < BaseBuilder
    def user_attributes
      case data[:account_type]
        when 'user' then user_attributes
        when 'page' then page_attributes
        else raise "unknown account_type: #{account_type}"
      end
    end

    def post_attributes
      {
        post_id:      data[:id],
        title:        data[:title],
        text:         data[:text],
        url:          data[:url],
        created_time: data[:created_time],
        location:     location,
      }.merge(media_data)
    end

    private

    def media_data
      extracted_attrs =
        case data[:type]
          when 'link', 'photo'
            {
              media_type: data[:type],
              image_url:  data[:picture],
              link_to:    data[:link]
            }
          when 'video'
            {
              media_type: data[:type],
              image_url:  data[:picture],
              link_to:    data[:link],
              video_src:  data[:source]
            }
          else {media_type: data[:type]}
        end

      extracted_attrs.delete_if { |_, v| !v }
    end

    def user_attributes
      {
        uid:              data[:actor][:uid].to_s,
        name:             data[:actor][:name],
        screen_name:      data[:actor][:username],
        image:            data[:actor][:pic_big] || data[:actor][:pic],
        location:         location,
        url:              data[:actor][:profile_url],
        followers_count:  data[:actor][:subscriber_count],
        friends_count:    data[:actor][:friend_count]
      }
    end

    def page_attributes(params)
      {
        uid:              data[:actor][:page_id].to_s,
        name:             data[:actor][:name],
        screen_name:      data[:actor][:username],
        image:            data[:actor][:pic_big] || data[:pic],
        location:         location,
        url:              data[:actor][:page_url],
        followers_count:  data[:actor][:fan_count],
        friends_count:    nil
      }
    end

    def location
      location_info = [data[:actor][:current_location], data[:actor][:current_address], data[:actor][:hometown_location]].compact.first
      if location_info
        location = ['country', 'state', 'city', 'street'].map { |field| location_info[field] }.compact
        location.join(', ').presence
      end
    end
  end
end
