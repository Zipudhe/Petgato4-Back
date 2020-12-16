class Reply < ApplicationRecord
    validates :description, presence: true
    validates :user_id, presence: true
    validates :comment_id, presence: true

end
