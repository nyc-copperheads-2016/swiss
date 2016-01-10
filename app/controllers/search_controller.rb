class SearchController < ApplicationController
  before_action :ensure_logged_in

  def search
    if params[:search] != ""
      results = Bookmark.find_by_fuzzy_content(params[:search], limit: 10)
      @search_results = ApplicationHelper.search(results, params[:search])
    end
  end

end