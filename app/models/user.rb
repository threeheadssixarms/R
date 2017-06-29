class User < ApplicationRecord
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

  validates :email,
    presence: true,
    length: {maximum: 255},
    format: {with: VALID_EMAIL_REGEX},
    uniqueness: {case_sensitive: false}
  validates :password,
    presence: true,
    length: {minimum: 6}
  validates :name,
    presence: true,
    length: {maximum: 50}
  has_secure_password

  before_save :downcase

  class << self
    def digest string
      if cost = ActiveModel::SecurePassword.min_cost
        BCrypt::Engine::MIN_COST
      else
        BCrypt::Engine.cost
      end
      BCrypt::Password.create string, cost: cost
    end
  end

  private

  def downcase
    email.downcase!
  end

end
