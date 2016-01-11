class UserBookmarksController < ApplicationController
  before_action :ensure_logged_in

  def index
      @user = current_user
      @user_bookmarks = @user.user_bookmarks
      @user_folders = current_user.folders
  end

  def show
    @user_bookmark = UserBookmark.find_by(id: params[:id])
  end

  def chrome
    @user_bookmark = UserBookmark.new
    render layout: false
  end

  def chrome_saved
    render layout: false
  end

  def new
    @user_bookmark = UserBookmark.new
    @user_bookmark.bookmark = Bookmark.new
  end

  def create
    @bookmark = Bookmark.find_or_initialize_by(bookmark_params)
    @user_bookmark = current_user.user_bookmarks.build(name: user_bookmark_params, bookmark: @bookmark)
    if @bookmark.save && @user_bookmark.save
      redirect_to user_bookmarks_path
    else
      flash[:notice] = "Invalid Parameters, Please Try Again"
      render 'new'
    end
  end

  def chrome_create
    @bookmark = Bookmark.find_or_initialize_by(url: params[:bookmark_attributes][:url])
    @user_bookmark = current_user.user_bookmarks.build(name: user_bookmark_params, bookmark: @bookmark)
    if @bookmark.save && @user_bookmark.save
      redirect_to chrome_saved_path
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
    redirect_to user_bookmarks_path
  end

  private
    def bookmark_params
      params.require(:user_bookmark).permit(bookmark_attributes:[:url])[:bookmark_attributes]
    end

    def user_bookmark_params
      params.require(:user_bookmark).permit(:name)[:name]
    end

    def user_bookmarks_edit_params
      params.require(:user_bookmark).permit(:name)
    end

end