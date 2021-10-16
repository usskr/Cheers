class PostsController < ApplicationController
  def new
    @post = Post.new
    @post.build_spot
    @spot = Spot.new
  end

  def create
    @post = Post.new(post_params)
    @post.user_id = current_user.id
    @post.start_time = Date.current
    if spot_params[:address].present? # addressが入力されている場合
      @spot = Spot.find_or_create_by(address: spot_params[:address]) # 同じaddressがすでにあればfind,なければcreateをする
      @post.spot = @spot # @post.update(spot_id: @spot.id)と同じ。spot_idをpostに入れ込む
    else
      @spot = Spot.new
    end
    if @post.save
      redirect_to post_path(@post)
    else
      render :new
    end
  end

  def index
    if params[:category]
      @posts = Post.where(category: params[:category]).order(id: "DESC")
    else
      @posts = Post.all.order(id: "DESC")
    end
  end

  def show
    @post = Post.find(params[:id])
    @post_comment = PostComment.new
    @spot = @post.spot
    if @spot
      @lat = @spot.latitude
      @lng = @spot.longitude
      gon.lat = @lat
      gon.lng = @lng
    end
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

  private

  def post_params
    params.require(:post).permit(:content, :image, :category, :start_time)
  end

  def spot_params
    params.require(:post).permit(spot: [:address])[:spot] # postモデルのフォームでspotモデルを扱っているため
  end
end
