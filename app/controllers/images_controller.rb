class ImagesController < ApplicationController
  def destroy
    PostImage.destroy(params[:id])
    redirect_back(fallback_location: root_path)
  end
end
