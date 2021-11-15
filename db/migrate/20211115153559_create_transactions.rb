class CreateTransactions < ActiveRecord::Migration[6.1]
  def change
    create_table :transactions do |t|
      t.datetime :date, :null => false, default: -> { 'CURRENT_TIMESTAMP' }
      t.integer :amount, :null => false, default: 0
      t.text :note
      t.datetime :debt_exp

      t.timestamps
    end

    add_reference :transactions, :wallet, foreign_key: true
    add_reference :transactions, :category, foreign_key: true
  end
end
