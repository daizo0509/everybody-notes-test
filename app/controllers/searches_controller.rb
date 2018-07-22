class SearchesController < ApplicationController
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
    @tags = @search.result(distinct: true)
  
  end

  def search
     groupings = []  # 空配列生成

    # パラメーターがあれば分割し、複数のAND条件分を生成する
    if params[:q].present?
      keywords = params[:q][:tag_name_cont].split(/[\p{blank}\s]+/)
      keywords.each { |value| groupings.push(tag_name_cont: value) }
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
   end

   private  
  def search_params
    params.require(:q).permit(:tags_list,:name)
  end

end
