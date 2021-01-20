class Report < ApplicationRecord
    validates :reply_id, presence: true, uniqueness: true
    validates :comment_id, presence: true, uniqueness: true

    has_one :reply
    has_one :comment
end
