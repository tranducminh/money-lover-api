class AddUserToUserWallets < ActiveRecord::Migration[6.1]
  def change
    add_reference :user_wallets, :user, foreign_key: true
  end
end
