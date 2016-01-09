class FolderController < ApplicationController
  def index
    @folders = Folder.all
  end
  def show
    @folder = Folder.find_by(id: params[:id])
  end

  def new
    @folder = Folder.new
  end

  def create
    @parent = Folder.find_by(params[:id])
    @folder = @parent.children.build(folder_params)
    if @folder.save!
      flash[:notice] = "Folder Successfully Created"
      redirect_to root_path
    else
      flash[:error] = "Unable to Create Folder"
      render 'new'
    end
  end

  def edit
    @folder = Folder.find_by(id: params[:id])
  end

  def update
    @folder = Folder.find_by(id: params[:id])
    if @folder.update!(folder_params)
      flash[:notice] = "Folder Successfully Updated"
      redirect_to root_path
    else
      flash[:error] = "Unable to Update Folder"
      render 'edit'
    end
  end

  def destroy
    @folder = Folder.find_by(id: params[:id])
    @folder.destroy
    redirect_to root_path
  end

  private
  def folder_params
    params.require(:folder).permit(:name)
  end
end

# we can take the collection of h3 tags iterate through them
# if node matches h3 create folder
# else create bookmark
#   then iterate through that collection and say if you are collection
#   do foreach on yourself
#    then another foreach on those if they are collection
#     etc.etc.etc.
#     recursively until everything is just a bookmark