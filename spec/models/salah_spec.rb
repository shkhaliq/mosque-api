require 'rails_helper'

RSpec.describe Salah, type: :model do
  # Association test
  # ensure an salah record belongs to a single mosque record
  it { should belong_to(:mosque) }
  # Validation test
  # ensure column name is present before saving
  it { should validate_presence_of(:name) }

  it { should validate_presence_of(:iqamah) }
end
