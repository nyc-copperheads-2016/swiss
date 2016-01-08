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
    # create or find the bookmark associated with the URL found in the parameters in the form
    bookmark = current_user.bookmarks.find_or_create_by(url: bookmark_params)
    # create the new bookmark for the user with the bookmark we passed in
    user_bookmark = current_user.user_bookmarks.new(name: user_bookmark_params, bookmark: bookmark)

    if bookmark.save && user_bookmark.save
      # take all the categories we passed in and make them each into their own tag associated with this particular user_bookmark
      separate_categories_and_save(params[:categories], user_bookmark)

      redirect_to user_bookmark
    else
      # flash errors and send them back to fix their problems
      render 'new'
    end
  end

  def update
  end

  def destroy
  end

  private
  def bookmark_params
    params.require(:user_bookmark).permit(:url)
  end

  def separate_categories_and_save(categories, user_bookmark)
    categories.split(",").each do |catergory|
      catergory.downcase.gsub(/,\s+/,"")
      user_bookmark.catergories.find_or_create_by(name: catergory)
    end
  end

  def user_bookmark_params
    params.require(:user_bookmark).permit(:name)
  end
end