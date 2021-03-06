class Contact < ApplicationRecord
    validates :name, presence: true
    validates :email, presence: true
    validates :description, presence: true, length: {maximum: 512}
end
