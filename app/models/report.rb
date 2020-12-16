class Report < ApplicationRecord
    validates :reply_id, presence: true
    validates :comment_id, presence: true

    has_one :reply
    has_one :comment
end
