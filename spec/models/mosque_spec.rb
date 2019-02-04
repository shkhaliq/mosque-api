require 'rails_helper'

RSpec.describe Mosque, type: :model do
    # Association test
  # ensure Mosque model has a 1:m relationship with the Item model
  it { should have_many(:salahs).dependent(:destroy) }
  # Validation tests
  # ensure columns name and publicly_accessible are present before saving
  it { should validate_presence_of(:name) }

end
