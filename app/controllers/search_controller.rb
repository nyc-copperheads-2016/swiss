class SearchController < ApplicationController
  include ApplicationHelper
  before_action :ensure_logged_in
def search
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