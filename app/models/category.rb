class Category < ApplicationRecord
  enum main_types: [:EXPENSE, :INCOME, :LOAN, :RECOVER_DEBT, :DEBT, :BACK_DEBT]

  CREATE_PARAMS = %i(name main_type icon).freeze
  UPDATE_PARAMS = %i(name main_type icon).freeze
  DEFAULT_CATEGORIES = [
    { name: "Food", main_type: Category::main_types[:EXPENSE] },
    { name: "Restaurant", main_type: Category::main_types[:EXPENSE] },
    { name: "Cafe", main_type: Category::main_types[:EXPENSE] },
    { name: "Rental bill", main_type: Category::main_types[:EXPENSE] },
    { name: "Water bill", main_type: Category::main_types[:EXPENSE] },
    { name: "Electricity bill", main_type: Category::main_types[:EXPENSE] },
    { name: "Gas bill", main_type: Category::main_types[:EXPENSE] },
    { name: "Internet bill", main_type: Category::main_types[:EXPENSE] },
    { name: "Movement", main_type: Category::main_types[:EXPENSE] },
    { name: "Taxi", main_type: Category::main_types[:EXPENSE] },
    { name: "Parking fee", main_type: Category::main_types[:EXPENSE] },
    { name: "Vehicle maintenance fee", main_type: Category::main_types[:EXPENSE] },
    { name: "Shopping", main_type: Category::main_types[:EXPENSE] },
    { name: "Movie", main_type: Category::main_types[:EXPENSE] },
    { name: "Game", main_type: Category::main_types[:EXPENSE] },
    { name: "Travel", main_type: Category::main_types[:EXPENSE] },
    { name: "Education", main_type: Category::main_types[:EXPENSE] },
    { name: "Another expense", main_type: Category::main_types[:EXPENSE] },

    { name: "Salary", main_type: Category::main_types[:INCOME] },
    { name: "Bonus", main_type: Category::main_types[:INCOME] },
    { name: "Another income", main_type: Category::main_types[:INCOME] },

    { name: "Loan", main_type: Category::main_types[:LOAN] },
    { name: "Recover a debt", main_type: Category::main_types[:RECOVER_DEBT] },
    { name: "Borrow money", main_type: Category::main_types[:DEBT] },
    { name: "Pay off a debt", main_type: Category::main_types[:BACK_DEBT] }
  ]

  belongs_to :wallet

  validates :name, presence: true,
    length: {
      maximum: Settings.validations.category.name.max_length,
      minimum: Settings.validations.category.name.min_length
    }
  validates :main_type, inclusion: {presence: true, in: Category::main_types.values}
end
