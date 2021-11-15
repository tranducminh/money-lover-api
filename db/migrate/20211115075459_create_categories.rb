class CreateCategories < ActiveRecord::Migration[6.1]
  def change
    create_table :categories do |t|
      t.string :name, null: false, default: ""
      t.integer :main_type, null: false, default: 0
      t.string :icon, null: false, default: ""

      t.timestamps
    end

    add_reference :categories, :wallet, foreign_key: true
  end
end
