class Salah < ApplicationRecord
  belongs_to :mosque
  # validation
  validates_presence_of :name, :iqamah
  validates_uniqueness_of :name

end
