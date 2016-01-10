class SearchController < ApplicationController
  before_action :ensure_logged_in

  def search
    # if params[:search] != ""
    #   results = Bookmark.find_by_fuzzy_content(params[:search], limit: 10)
    #   @search_results = ApplicationHelper.search(results, params[:search])
    # end
    if params[:q].nil?
      @search_results = []
    else
      @search_results = Elasticsearch::Model.search(params[:q], [Bookmark]).records.to_a

    end
  end

  def show
    @bookmark = UserBookmark.find_by(id: params[:id])
  end
end