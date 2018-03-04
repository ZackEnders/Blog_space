class Comment < ApplicationRecord
	belongs_to :blog
	belongs_to :user
	validates :body, presence: true, allow_blank: false
end
