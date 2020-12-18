class User < ApplicationRecord
    # Associations
    has_many :comments,  dependent: :destroy 
    has_many :likes,  dependent: :destroy 
    has_many :replies,  dependent: :destroy 

    # Criptografar a senha
    has_secure_password

    # Validações
    validates :name, presence: true
    validates :email, presence: true, uniqueness: true

    # Active Storage para profile picture
    has_one_attached :image
end
