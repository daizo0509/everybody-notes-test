class PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :update, :destroy]
  before_action :set_search
  # GET /posts
  # GET /posts.json
  
  def index
     groupings = []  # 空配列生成

    # パラメーターがあれば分割し、複数のAND条件分を生成する
    if params[:q].present?
      keywords = params[:q][:tags_name_cont].split(/[\p{blank}\s]+/)
      keywords.each { |value| groupings.push(tags_name_cont: value) }
    end

    # 生成したAND条件を検索する。初期の場合、全件出力
    @search = Post.ransack(
        combinator: 'or',
        groupings: groupings
    )
    @posts = Post.all
    # 追加
    @tags = @search.result
    # binding.pry

    @tag_ranking = Tag.all.sort_by{|p| p.taggings_count}.reverse #ランキング
  end


  # GET /posts/1
  # GET /posts/1.json
  def show
    @post = Post.find(params[:id])
    @post_comment = PostComment.new
    @comments = PostComment.where(post_id: @post.id)
    @Likes = Like.where(post_id: params[:id])
   

  end

  # GET /posts/new
  def new
    @post = Post.new
  end

  # GET /posts/1/edit
  def edit
  end

  # POST /posts
  # POST /posts.json
  def create
    @post = Post.new(post_params)
    @post.user_id = current_user.id

    respond_to do |format|
      if @post.save(post_params)
        format.html { redirect_to @post, notice: 'Post was successfully created.' }
        format.json { render :show, status: :created, location: @post }
      else
        format.html { render :new }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /posts/1
  # PATCH/PUT /posts/1.json
  def update
    respond_to do |format|
      if @post.update(post_params)
        format.html { redirect_to @post, notice: 'Post was successfully updated.' }
        format.json { render :show, status: :ok, location: @post }
      else
        format.html { render :edit }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /posts/1
  # DELETE /posts/1.json
  def destroy
    @post.destroy
    respond_to do |format|
      format.html { redirect_to posts_url, notice: 'Post was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_post
      @post = Post.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def post_params
      params.require(:post).permit(:title, :content,:user_id,:tag_list)
    end

    def set_search
       @search = Tag.ransack(params[:q])
    end
end
