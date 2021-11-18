class CreateTeams < ActiveRecord::Migration[6.1]
  def change
    create_table :teams do |t|
      t.string :name, null: false, default: ""

      t.timestamps
    end

    add_reference :teams, :user, foreign_key: true
    add_reference :wallets, :team, foreign_key: true
  end
end
