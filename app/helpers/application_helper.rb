module ApplicationHelper

  def find_user_records(current_user, results)
    user_bookmark_ids = current_user.user_bookmarks.map {|bookmark| bookmark.id}
    array = []
    user_bookmark_ids.each do |id|
      results.each do |bookmark| 
        array << bookmark if bookmark.id == id
      end
    end
      return array
  end

  def self.clean(html_string)
    remove_all_white_space_between_tags(condense_whitespace(html_string)).strip
  end

  def self.current_user_id
    session[:user_id] if session
  end

  private
    WHITE_SPACE_BETWEEN_TAGS = /(?<=>)\s+(?=<)/

    def self.remove_all_white_space_between_tags(html_string)
      html_string.gsub(WHITE_SPACE_BETWEEN_TAGS, "")
    end

    def self.condense_whitespace(html_string)
      html_string.gsub(/\s+/, ' ')
    end

end