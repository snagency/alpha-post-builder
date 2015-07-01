module AlphaPostBuilder
  class YandexBuilder < BaseBuilder
    def user_attributes
      {
        uid: author_url ? author_url : data[:author],
        name: author_name || screen_name,
        screen_name: screen_name,
        url: author_url
      }
    end

    def post_attributes
      {
        post_id:      data[:id],
        title:        data[:title],
        text:         data[:summary].try(:strip),
        url:          data[:url] ? data[:url][0..249] : nil,
        created_time: data[:published].to_i,
      }
    end

    private

    def author_url
      url = data[:yablogs_author_url] || data[:author]
      return url if url =~ /http(s|):\/\//
    end

    def author_name
      name = data[:yablogs_author] || data[:author]
      return nil if name =~ /http(s|):\/\//
    end

    def screen_name
      if author_url
        author_name   = author_url.split('/')[3]
        author_name   = author_url.split('/')[4] if ['mail', 'users'].include?( author_name )
        author_name ||= author_url.split('/')[2].split('.')[0] if author_url.split('/')[2] && author_url.split('/')[2].split('.').size == 3
        author_name   = author_url.split('/')[2].split('.')[1] if ['www'].include?( author_name )
        author_name
      end
    end
  end
end
