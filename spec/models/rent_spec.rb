require 'rails_helper'

RSpec.describe Rent, type: :model do
  it { is_expected.to validate_presence_of(:cpf) }
  it { is_expected.to validate_presence_of(:start_date) }
  it { is_expected.to validate_presence_of(:end_date) }
  it { should validate_length_of(:cpf).is_equal_to(11) }
end
