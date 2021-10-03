class CheersController < ApplicationController
  def create
    @post = Post.find(params[:post_id])
    cheer = @post.cheers.new(user_id: current_user.id)
    cheer.save
    redirect_to request.referer
  end

  def destroy
    @post = Post.find(params[:post_id])
    cheer = @post.cheers.find_by(user_id: current_user.id)
    cheer.destroy
    redirect_to request.referer
  end
end
