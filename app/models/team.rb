class Team < ApplicationRecord
  CREATE_PARAMS = %i(name).freeze
  UPDATE_PARAMS = %i(name).freeze

  belongs_to :owner, class_name: "User", foreign_key: :user_id
  has_many :wallets, dependent: :destroy

  validates :name, presence: true,
    length: {
      maximum: Settings.validations.team.name.max_length,
      minimum: Settings.validations.team.name.min_length
    }
end
