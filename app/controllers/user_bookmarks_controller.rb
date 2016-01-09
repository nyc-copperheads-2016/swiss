class UserBookmarksController < ApplicationController
  before_action :ensure_logged_in

  def index
    if params[:search] != ""
      results = Bookmark.find_by_fuzzy_content(params[:search], limit: 10)
      @search_results = ApplicationHelper.search(results, params[:search])
    end
      @user = current_user
      @user_bookmarks = @user.user_bookmarks.all
  end

  def show
    @user_bookmark = UserBookmark.find_by(id: params[:id])
  end

  def new
    @user_bookmark = UserBookmark.new
    @user_bookmark.bookmark = Bookmark.new
  end

  def create
    @user_bookmark = current_user.user_bookmarks.build(user_bookmarks_params)
    if @user_bookmark.save!
      redirect_to user_bookmarks_path
    else
      flash[:notice] = "Invalid Parameters, Please Try Again"
      render 'new'
    end
  end

  def edit
    @user_bookmark = UserBookmark.find_by(id: params[:id])
  end

  def update
    @user_bookmark = UserBookmark.find_by(id: params[:id])
    if @user_bookmark.update!(user_bookmarks_edit_params)
      redirect_to @user_bookmark
    else
      render :edit
    end
  end

  def destroy
    @user_bookmark = UserBookmark.find_by(id: params[:id])
    @user_bookmark.destroy
    redirect_to root_path
  end

  private
  def user_bookmarks_params
    params.require(:user_bookmark).permit(:name, bookmark_attributes: [:url])
  end

  def user_bookmarks_edit_params
    params.require(:user_bookmark).permit(:name,)
  end

end