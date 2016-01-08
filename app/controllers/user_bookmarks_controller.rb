class UserBookmarksController < ApplicationController
  before_action :ensure_logged_in

  def index
    # for MVP we will automatically make the user's boomkarks only show the current user.
    # For stretch we would like the option for you to view a different user's bookmarks when creating a community
    # @user = current_user()
    @user = current_user
    @user_bookmarks = @user.user_bookmarks.all
  end

  def show
    @user_bookmark = UserBookmark.find_by(id: params[:id])
  end

  def new
    @user_bookmark = UserBookmark.new()
  end

  def create
    bookmark = Bookmark.find_or_create_by(url: params[:url])
    user_bookmark = current_user.user_bookmarks.new(name: params[:user_bookmark][:name], bookmark: bookmark)
    if user_bookmark.save
      redirect_to user_bookmarks_path
    else
      # flash errors and send them back to fix their problems
      flash[:notice] = "Invalid Parameters, Please Try Again"
      render 'new'
    end
  end

  def edit
    @user_bookmark = UserBookmark.find_by(id: params[:id])
  end

  def update
    # this is calling the update method for the associated categories and bookmarks
    @user_bookmark = UserBookmark.find_by(id: params[:id])
    bookmark = @user_bookmark.bookmark
    # logically we would want to take in all the user's category changes
    @user_bookmark.categories.clear()
    if @user_bookmark.update_attributes(name: params[:user_bookmark][:name]) && bookmark.update_attributes(url: params[:url])
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

end