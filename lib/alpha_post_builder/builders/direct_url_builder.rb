module AlphaPostBuilder
  class DirectUrlBuilder < BaseBuilder
    def user_attributes
      {
        uid: data[:user_id],
        name: data[:author]
      }
    end

    def post_attributes
      {
        post_id:      data[:id],
        title:        data[:title],
        text:         data[:content] || data[:summary],
        url:          data[:url] || data[:entry_id],
        created_time: data[:published].to_i,
      }
    end
  end
end
