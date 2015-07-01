module AlphaPostBuilder
  class VkontakteBuilder < BaseBuilder
    def user_attributes
      {
        uid:              data[:author][:id].to_s,
        name:             data[:author][:name],
        screen_name:      data[:author][:screen_name],
        image:            data[:author][:photo_200] || data[:author][:photo_100] || data[:author][:photo_50],
        location:         data[:author][:location],
        url:              data[:author][:url],
        followers_count:  counters[:followers_count]
      }
    end

    def post_attributes
      {
        post_id:      data[:id],
        text:         data[:text],
        created_time: data[:date],
        location:     data[:location],
        url:          data[:url]
      }.merge(media_data)
    end

    private

    def media_data
      media = data[:attachment] || data[:attachments].try(:[], 0)
      if media
        media_type = media[:type]
        media = media[media_type.to_sym]
        case media_type
          when 'photo', 'posted_photo', 'graffiti'
            {
              title:      media[:text],
              media_type: media_type,
              image_url:  media[:photo_807] || media[:photo_604]|| media[:photo_130],
            }
          when 'video'
            {
              title:      media[:title],
              media_type: media_type,
              image_url:  media[:photo_640] || media[:photo_320] || media[:photo_130],
              video_src:  "#{media[:owner_id]}_#{media[:id]}"
            }
          when 'link'
            {
              title:      media[:title] ? media[:title][0..254] : nil,
              media_type: media_type,
              image_url:  media[:image_src],
              link_to:    media[:url],
            }
          else
            {media_type: media_type}
        end
      else
        {}
      end
    end

    def counters
      if data[:id] && data[:id].to_i > 0
        { followers_count: data[:author][:followers_count] }
      else
        { followers_count: data[:author][:members_count] }
      end
    end
  end
end
