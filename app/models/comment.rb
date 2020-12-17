class Comment < ApplicationRecord
    validates :description, presence: true
    validates :post_id, presence: true
    validates :user_id, presence: true

    has_many :reports
    has_many :replies
    has_one :user
    has_one :post

end
