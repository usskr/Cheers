class PostsController < ApplicationController
  def new
    @post = Post.new
    @post.build_spot
  end

  def create
    @post = Post.new(post_params)
    @post.user_id = current_user.id
    @post.start_time = Date.current
    if @post.save
      redirect_to post_path(@post)
    else
      redirect_to new_post_path
    end
  end

  def index
    if params[:category]
      @posts = Post.where(category: params[:category])
    else
      @posts = Post.all
    end
  end

  def show
    @post = Post.find(params[:id])
    @post_comment = PostComment.new
    @lat = @post.spot.latitude
    @lng = @post.spot.longitude
    gon.lat = @lat
    gon.lng = @lng
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    redirect_to posts_path
  end

  def search
    @posts = Post.search(params[:keyword])
    @keyword = params[:keyword]
  end

  # def rank
  #   to  = Time.current.at_end_of_day
  #   from  = (to - 6.day).at_beginning_of_day
  #   @posts = Post.includes(:cheered_users).
  #     sort {|a,b|
  #       b.cheered_users.includes(:cheers).where(created_at: from...to).size <=>
  #       a.cheered_users.includes(:cheers).where(created_at: from...to).size
  #     }.first(5)
  # end

  private

  def post_params
    params.require(:post).permit(:content, :image, :category, :start_time, spot_attributes: [:address])
  end
end
