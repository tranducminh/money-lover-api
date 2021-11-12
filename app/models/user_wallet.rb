class UserWallet < ApplicationRecord
  CREATE_PARAMS = %i(user_id wallet_id user_role).freeze
  DESTROY_PARAMS = %i(user_id wallet_id).freeze

  belongs_to :user
  belongs_to :wallet

  validates :user_role, inclusion: {presence: true, in: User::roles}
end
