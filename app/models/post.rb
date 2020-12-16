class Post < ApplicationRecord
    # Callback para manipular o valor default de views
    before_save :default_value

    # Action Text
    has_rich_text :content

    # Action Storage banner image
    has_one_attached :image
    
    # Validações
    validades :name, presence: true
    validates :content, presence: true

    # Colocar o valor padrão de views para 0
    def default_value
        self.views = 0
    end
end
