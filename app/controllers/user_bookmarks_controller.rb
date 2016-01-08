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
    @user = current_user
    @user_bookmark = @user.UserBookmark.new
  end

  def create
    # make a new bookmark, category, and user_bookmark. using current user as user id.
    # create or find the bookmark associated with the URL found in the parameters in the form

    bookmark = Bookmark.find_or_create_by(url: bookmark_params)
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

  def edit
    @user_bookmark = UserBookmark.find_by(id: params[:id])
  end

  def update
    # this is calling the update method for the associated categories and bookmarks
    @user_bookmark = UserBookmark.find_by(id: params[:id])
    bookmark = @user_bookmark.bookmark
    # logically we would want to take in all the user's category changes
    @user_bookmark.categories.clear()
    if @user_bookmark.update_attributes(user_bookmark_params) && bookmark.update_attributes(bookmark_params)
      separate_categories_and_save(params[:categories], user_bookmark)
      redirect_to @user_bookmark
    else
      render :edit
    end
  end

  def destroy
  end

  private
  def bookmark_params
    params.require(:user_bookmark).permit(:url)
  end

  def separate_categories_and_save(categories, user_bookmark)
    categories.split(",").each do |category|
      category.downcase.gsub(/,\s+/,"")
      user_bookmark.categories.find_or_create_by(name: category)
    end
  end

  def user_bookmark_params
    params.require(:user_bookmark).permit(:name)
  end
end