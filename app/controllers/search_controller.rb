class SearchController < ApplicationController
  include ApplicationHelper
  before_action :ensure_logged_in

  def search
    if params[:q].nil?
      @search_results = []
    else
      @bookmarks_array = Elasticsearch::Model.search(params[:q], [Bookmark]).records.to_a
      @search_results = find_user_records(current_user, @bookmarks_array)
    end
  end

  def show
    @bookmark = UserBookmark.find_by(id: params[:id])
  end
end