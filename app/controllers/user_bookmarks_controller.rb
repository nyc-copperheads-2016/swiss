class UserBookmarksController < ApplicationController

  def index
    # for MVP we will automatically make the user's boomkarks only show the current user.
    # For stretch we would like the option for you to view a different user's bookmarks when creating a community
    @user = current_user()
    @user_bookmarks = @user.UserBookmark.all
  end

  def show
    @user_bookmark = UserBookmark.find_by(id: params[:id])
  end

  def new
    @user_bookmark = UserBookmark.new()
  end

  def create
    # make a new bookmark, category, and user_bookmark. using current user as user id.
  end
  def edit
  end
  def destroy
  end

  private
  def bookmark_params
    params.require(:user_bookmark).permit(:url)
  end

  def category_params
    params.require(:user_bookmark).permit(:categories)
  end

  def user_bookmark_params
    params.require(:user_bookmark).permit(:name)
  end
end