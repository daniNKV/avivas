module Admin::UsersHelper
  def avatar_url(user)
    if user.avatar.attached?
      Rails.application.routes.url_helpers.rails_blob_path(user.avatar, only_path: true)
    else
      "/images/default_avatar.webp"
    end
  end
end
