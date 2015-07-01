module AlphaPostBuilder
  class InstagramBuilder < BaseBuilder
    def user_attributes
      {
        uid:          data[:user][:id].to_s,
        name:         data[:user][:full_name],
        screen_name:  data[:user][:username],
        image:        data[:user][:profile_picture],
        url:          "https://instagram.com/#{data[:user][:username]}"
      }
    end

    def post_attributes
      {
        post_id:      data[:id],
        text:         data[:caption] ? data[:caption][:text] : nil,
        image_url:    data[:images][:standard_resolution][:url],
        created_time: data[:created_time],
        url:          data[:link],
        video_src:    data[:videos] ? data[:videos][:standard_resolution][:url] : nil,
        location:     location,
        media_type:   data[:type],
      }
    end

    private

    def location
      if data[:location]
        "#{data[:location][:name]} (#{data[:location][:latitude]},#{data[:location][:longitude]})"
      end
    end
  end
end
