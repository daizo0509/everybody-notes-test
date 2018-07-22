class Tag < ApplicationRecord
	has_many :tagging
	has_many :posts ,through: :taggings
	accepts_nested_attributes_for :posts
end
