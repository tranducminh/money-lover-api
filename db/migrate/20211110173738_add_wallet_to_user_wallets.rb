class AddWalletToUserWallets < ActiveRecord::Migration[6.1]
  def change
    add_reference :user_wallets, :wallet, foreign_key: true
  end
end
