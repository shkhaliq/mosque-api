class Salah < ApplicationRecord
  belongs_to :mosque
  # validation
  validates_presence_of :name

  validates_presence_of :iqamah
end
