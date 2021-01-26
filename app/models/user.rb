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

    # Requisitos do email
    EMAIL_PATTERN = /\A[A-Za-z0-9+_.-]+@[A-Za-z0-9.-]/x

    # Validações
    validates :name, presence: true
    validates :email, presence: true, uniqueness: true, format: EMAIL_PATTERN
    validates :password, format: PASSWORD_REQUIREMENTS

    # Active Storage para profile picture
    has_one_attached :profile_image
end
