class LikesController < ApplicationController
  before_action :set_post, only: [:create, :destroy]
  def create
    # micropostを取得します。（before_actionをしっていたら共通化しましょう）
    @post = Post.find(params[:post_id])

    @like = Like.create(user_id: current_user.id, post_id: params[:post_id])
    respond_to do |format|
        format.js
        #format.jsを追加
      end
    # 以下は多分必要ないので削除
    # @likes = Like.where(micropost_id: params[:micropost_id])
    # @microposts = Micropost.all
     @post.reload
    
  end

  def destroy
    # micropostを取得します。（before_actionをしっていたら共通化しましょう）
    @post = Post.find(params[:post_id])

    @like = Like.find_by(user_id: current_user.id, post_id: params[:post_id]).destroy
   respond_to do |format|
        
        #scaffoldにformat.jsを追加
        format.js
        #format.jsを追加
      end
      @post.reload

    # 以下は多分必要ないので削除
    # @likes = Like.where(micropost_id: params[:micropost_id])
    # @microposts = Micropost.all
  end

   private

  def set_post
    @tweet = Post.find(params[:post_id])
  end
end
