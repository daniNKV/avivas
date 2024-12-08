class User < ApplicationRecord
  include Clearance::User
  has_one_attached :avatar
  before_save :normalize_phone_number

  enum :role, {
    member: 0,
    employee: 1,
    manager: 2,
    admin: 3
  }, suffix: true

  enum :status, { active: 0, inactive: 1, blocked: 2 }, suffix: true

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

  private
  def normalize_phone_number
    self.phone= Phonelib.parse(phone).international if phone.present?
  end
end
