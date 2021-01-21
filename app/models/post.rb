class Post < ApplicationRecord
    # Associations
    has_many :tag_posts,  dependent: :destroy 
    has_many :comments,  dependent: :destroy 
    has_many :likes,  dependent: :destroy 

    # Callback para manipular o valor default de views
    before_create :default_value

    # Action Text
    has_rich_text :content

    # Action Storage banner image
    has_one_attached :banner
    
    # Validações
    validates :name, presence: true
    validates :content, presence: true

    # Colocar o valor padrão de views para 0
    def default_value
        self.views = 0
    end
end
