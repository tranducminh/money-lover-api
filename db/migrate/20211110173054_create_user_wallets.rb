class CreateUserWallets < ActiveRecord::Migration[6.1]
  def change
    create_table :user_wallets do |t|
      t.integer :user_role, null: false, default: 0

      t.timestamps
    end
  end
end
