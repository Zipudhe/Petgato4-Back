class User < ApplicationRecord
    #has_many :comments
    #has_many :likes
    #has_many :replies

    has_secure_password

    validates :name, presence: true
    validates :email, presence: true, uniqueness: true

    has_one_attached :image
end
