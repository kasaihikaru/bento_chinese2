class Sentence < ApplicationRecord
	belongs_to :user
	belongs_to :fold

	has_many :words
	accepts_nested_attributes_for :words

	has_many :likes, dependent: :destroy
	accepts_nested_attributes_for :likes

	validates :ja, presence: true
	validates :ch, presence: true
	validates :fold_id, presence: true

	def like_user(user_id)
		likes.find_by(user_id: user_id)
	end
end