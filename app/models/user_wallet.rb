class UserWallet < ApplicationRecord
  belongs_to :user
  belongs_to :wallet

  validates :user_role, inclusion: {presence: true, in: User::roles}
end
