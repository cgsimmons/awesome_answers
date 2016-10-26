class User < ApplicationRecord
  has_many :questions, dependent: :nullify
  has_many :answers, dependent: :nullify
  has_secure_password
  before_validation :downcase_email

  VALID_EMAIL_REGEX = VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i

  validates :first_name, presence: true
  validates :last_name, presence:true

  validates :email, presence: true,
                   uniqueness: { case_sensitive: false },
                   format: VALID_EMAIL_REGEX

  def full_name
    "#{first_name} #{last_name}".strip.squeeze(' ').titleize
  end

  private
  def downcase_email
    self.email.downcase! if email.present?
  end

end
