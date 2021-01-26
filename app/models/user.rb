class User < ApplicationRecord
    # Associations
    has_many :comments,  dependent: :destroy 
    has_many :likes,  dependent: :destroy 
    has_many :replies,  dependent: :destroy 

    # Criptografar a senha
    has_secure_password

    # Requisitos da senha
    PASSWORD_REQUIREMENTS = /\A
        (?=.{8,})
        (?=.*\d)
    /x

    # Validações
    validates :name, presence: true
    validates :email, presence: true, uniqueness: true
    validates :password, format: PASSWORD_REQUIREMENTS

    # Active Storage para profile picture
    has_one_attached :profile_image
end
