class UserWallet < ApplicationRecord
  belongs_to :user
  belongs_to :wallet
end
