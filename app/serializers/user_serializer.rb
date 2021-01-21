class UserSerializer < ActiveModel::Serializer
  include Rails.application.routes.url_helpers
  attributes :id, :name, :email, :password_digest, :is_admin, :profile_image

  '''
  def profile_image
    if object.profile_image.attached?
      {
        url: rails_blob_url(object.profile_image)
      }
    end
  end
  '''
end
