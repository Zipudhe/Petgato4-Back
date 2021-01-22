class Reply < ApplicationRecord
    validates :description, presence: true
    validates :user_id, presence: true
    validates :comment_id, presence: true

    has_one :user
    has_one :comment
    
end
