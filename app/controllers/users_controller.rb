class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      Folder.create!(name: @user.username, user: @user)
      flash[:notice] = 'Congratulations! You Are Ready To Bookmark!'
      redirect_to root_path
    else
      render :new
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attribute(:bookmark_file, params[:user][:bookmark_file])
      redirect_to user_bookmarks_path
    else
      redirect_to user_bookmarks_path
    end
  end

  def destroy
    @user = User.find(params[:id]).destroy
    flash[:success] = "User deleted"
    redirect_to login_path
  end

  def user_params
    params.require(:user).permit(:username, :email, :last_name, :first_name, :password, :password_confirmation, :bookmark_file)
  end
end
