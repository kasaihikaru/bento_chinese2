class Fold < ApplicationRecord
	belongs_to :user
	has_many :sentences

	scope :active, -> { where(deleted: false) }
end
