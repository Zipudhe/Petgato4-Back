class Tag < ApplicationRecord
    validates :name, presence: true
    validates :description, presence: true

    has_many :tag_posts,  dependent: :destroy 

end
