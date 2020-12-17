class User < ApplicationRecord
    # Associations
    has_many :comments
    has_many :likes
    has_many :replies

    # Criptografar a senha
    has_secure_password

    # Validações
    validates :name, presence: true
    validates :email, presence: true, uniqueness: true

    # Active Storage para profile picture
    has_one_attached :image
end
