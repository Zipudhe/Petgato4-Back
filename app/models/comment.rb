class Comment < ApplicationRecord
    validates :description, presence: true
    validates :post_id, presence: true
    validates :user_id, presence: true

    has_many :reports,  dependent: :destroy 
    has_many :replies,  dependent: :destroy 
    has_one :user
    has_one :post

end
