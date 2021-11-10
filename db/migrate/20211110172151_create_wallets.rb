class CreateWallets < ActiveRecord::Migration[6.1]
  def change
    create_table :wallets do |t|
      t.string :name, null: false, default: ""
      t.integer :total, null: false, default: 0
      t.boolean :is_freezed, null: false, default: false

      t.timestamps
    end
  end
end
