class User < ApplicationRecord
  USER_PARAMS = %i(email password password_confirmation name).freeze
  LOGIN_PARAMS = %i(email password).freeze

  enum roles: [:OWNER, :MANAGER, :OBSERVER]

  has_many :user_wallets, dependent: :destroy

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
end
