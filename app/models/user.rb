class User < ApplicationRecord
  include Clearance::User
  has_one_attached :avatar
  has_many :invoices
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

  validates :bio,
            length: { maximum: 250, allow_blank: true }

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

  validates :role,
            presence: true,
            inclusion: { in: roles.keys }

  validates :joined_at,
            presence: true,
            comparison: { less_than_or_equal_to: Date.today }

  def full_name
    "#{first_name} #{last_name}"
  end
  def admin?; admin_role?; end
  def manager?; manager_role?; end
  def employee?; employee_role?; end
  def blocked?; blocked_status?; end
  def active?; active_status?; end
  def inactive?; inactive_status?; end


  private
  def normalize_phone_number
    self.phone= Phonelib.parse(phone).international if phone.present?
  end
end
