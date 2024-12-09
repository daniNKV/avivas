class User < ApplicationRecord
  include Clearance::User
  has_one_attached :avatar
  before_save :normalize_phone_number

  enum :role, [ :member, :employee, :manager, :admin ], suffix: true

  enum :status, [ :active, :inactive, :blocked ], suffix: true

  scope :by_name_or_email, ->(query) {
    where("LOWER(first_name) LIKE :search OR LOWER(username) LIKE :search OR LOWER(last_name) LIKE :search OR LOWER(email) LIKE :search",
          search: "%#{query.downcase}%")
  }
  scope :by_role, ->(role) {
    where(role: role)
  }
  scope :by_status, ->(status) {
    where(status: status)
  }

  validates :username,
            presence: true,
            uniqueness: { case_sensitive: false },
            length: {
              minimum: 3,
              maximum: 50
            },
            format: {
              with: /\A[a-zA-Z0-9_]+\z/,
              message: "can only contain letters, numbers, and underscores"
            }

  validates :email,
            presence: true,
            uniqueness: { case_sensitive: false },
            format: {
              with: URI::MailTo::EMAIL_REGEXP,
              message: "must be a valid email address"
            }

  validates :phone,
            phone:
              {
                possible: true,
                allow_blank: true,
                types: [ :mobile ],
                countries: [ :ar, :us ]
              }

  validates :first_name,
            length: {
              minimum: 2,
              maximum: 50,
              allow_blank: true
            }

  validates :last_name,
            length: {
              minimum: 2,
              maximum: 50,
              allow_blank: true
            }

  validates :role,
            presence: true,
            inclusion: { in: roles.keys }

  validates :joined_at,
            presence: true,
            comparison: { less_than_or_equal_to: Date.today }

  def full_name
    "#{first_name} #{last_name}"
  end
  def admin?; role == :admin; end
  def manager?; role == :manager; end
  def employee?; role == :employee; end
  def blocked?; status == :blocked; end
  def block
    self.status = :blocked
    self.password = SecureRandom.hex(20)
    save!
  end
  def avatar_url
    if avatar.attached?
      Rails.application.routes.url_helpers.rails_blob_path(avatar, only_path: true)
    else
      "/images/default_avatar.webp"
    end
  end

  private
  def normalize_phone_number
    self.phone= Phonelib.parse(phone).international if phone.present?
  end
end
