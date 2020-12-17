class TagPost < ApplicationRecord
    validates :post_id, presence: true
    validates :tag_id, presence: true

    has_one :post
    has_one :tag
end
