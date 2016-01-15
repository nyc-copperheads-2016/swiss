class SnippitsController < ApplicationController
  before_action :ensure_logged_in

  def new
    @user_bookmark = UserBookmark.find(params[:user_bookmark_id])
    @snippit = Snippit.new
  end

  def create
    user_bookmark = UserBookmark.find(params[:user_bookmark_id])
    @snippit = user_bookmark.snippits.build(snippit_params)
    if @snippit.save
      flash[:notice] = "Snippet Successfully Created"
      redirect_to user_bookmarks_path
    else
      flash[:error] = "Unable to Create Snippet"
      render 'new'
    end
  end

  def show
    @snippit = Snippit.find(params[:id])
  end

  def edit
    @user_bookmark = UserBookmark.find_by(id: params[:user_bookmark_id])
    @snippit = Snippit.find_by(id: params[:id])
  end

  def update
    @snippit = Snippit.find_by(id: params[:id])
    if @snippit.update(snippit_params)
      flash[:notice] = "Snippet Successfully Updated"
      redirect_to user_bookmarks_path
    else
      flash[:error] = "Unable to Update Snippet"
      render 'edit'
    end
  end

  def destroy
    @snippit = Snippit.find_by(id: params[:id])
    @snippit.destroy
    redirect_to user_bookmarks_path
  end

  private
  def snippit_params
    params.require(:snippit).permit(:name, :content, :user_bookmark_id)
  end
end
