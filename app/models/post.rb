class Post < ApplicationRecord
	
	belongs_to :user
	has_many :likes, dependent: :destroy
	  def like_user(user_id)
	   likes.find_by(user_id: user_id)
	  end
	has_many :taggings
	has_many :tags ,through: :taggings

	acts_as_taggable_on :skill # post.label_list が追加される
  	acts_as_taggable            # acts_as_taggable_on :tags のエイリアス
end
