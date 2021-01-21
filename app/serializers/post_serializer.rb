class PostSerializer < ActiveModel::Serializer
  attributes :id, :name, :content, :views, :created_at, :updated_at,  :image
"""
  def image
    if object.image.attached?
      {
        url: rails_blob_url(object.image)
      }
    end
  end
"""
end
