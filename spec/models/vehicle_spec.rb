require 'rails_helper'

RSpec.describe Vehicle, type: :model do
  it { is_expected.to validate_presence_of(:model) }
  it { is_expected.to validate_presence_of(:manufacture) }
  it { is_expected.to validate_presence_of(:license_plate) }
  it { should validate_uniqueness_of(:license_plate) }
end
