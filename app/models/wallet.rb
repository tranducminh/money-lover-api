class Wallet < ApplicationRecord
  CREATE_PARAMS = %i(name)
  UPDATE_PARAMS = %i(name is_freezed)

  has_many :user_wallets, dependent: :destroy
end
