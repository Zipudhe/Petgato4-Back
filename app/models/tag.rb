class Tag < ApplicationRecord
    validates :name, presence: true
    validates :description, presence: true

    has_many :tagposts

end
