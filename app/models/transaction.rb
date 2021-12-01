class Transaction < ApplicationRecord
  CREATE_PARAMS = %i(category_id date amount note debt_exp).freeze
  UPDATE_PARAMS = %i(category_id date amount note debt_exp).freeze

  belongs_to :wallet
  belongs_to :category

  validates :note, allow_blank: true,
    length: { maximum: Settings.validations.transaction.note.max_length }
  validates :amount, presence: true,
    numericality: { 
      greater_than: Settings.validations.transaction.amount.min,
      less_than: Settings.validations.transaction.amount.max
    }
end
