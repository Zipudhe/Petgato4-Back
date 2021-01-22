class Report < ApplicationRecord
    validates :comment_id, presence: true
    
    has_one :comment
end
