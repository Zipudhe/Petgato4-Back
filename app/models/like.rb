class Like < ApplicationRecord
    # Associations
    has_one :post
    has_one :user

    # Validations
    validates :post_id, presence: true
    validates :user_id, presence: true
end
