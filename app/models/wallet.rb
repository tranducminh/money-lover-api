class Wallet < ApplicationRecord
  CREATE_PARAMS = %i(name team_id).freeze
  UPDATE_PARAMS = %i(name is_freezed team_id).freeze

  has_many :user_wallets, dependent: :destroy
  has_many :categories, dependent: :destroy
  has_many :transactions, dependent: :destroy
  belongs_to :team

  validates :name, presence: true,
    length: {
      maximum: Settings.validations.wallet.name.max_length,
      minimum: Settings.validations.wallet.name.min_length
    }
  validates :is_freezed, inclusion: {presence: true, in: [true, false]}
  validates :total, numericality: { only_integer: true }
end
