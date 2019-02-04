class Mosque < ApplicationRecord
      # model association
  has_many :salahs, dependent: :destroy

  # validations
  validates_presence_of :name
end
