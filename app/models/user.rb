class User < ApplicationRecord
  USER_PARAMS = %i(email password password_confirmation name).freeze
  LOGIN_PARAMS = %i(email password).freeze

  enum roles: [:OWNER, :MANAGER, :OBSERVER]

  has_many :user_wallets, dependent: :destroy

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :name, presence: true,
    length: {
      maximum: Settings.validations.user.name.max_length,
      minimum: Settings.validations.user.name.min_length
    }
  validates :email, presence: true,
    length: {maximum: Settings.validations.user.email.max_length},
    format: {with: Settings.validations.user.email.regex},
    uniqueness:  {case_sensitive: false}
  validates :password, presence: true,
    length: {minimum: Settings.validations.user.password.min_length}
end
