class PostSerializer < ActiveModel::Serializer
  attributes :id, :name, :content, :views, :image

  def image
    if object.image.attached?
      {
        url: rails_blob_url(object.image)
      }
    end
  end
end
