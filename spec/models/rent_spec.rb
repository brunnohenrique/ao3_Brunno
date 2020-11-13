require 'rails_helper'

RSpec.describe Rent, type: :model do
  it { is_expected.to validate_presence_of(:cpf) }
  it { is_expected.to validate_presence_of(:start_date) }
  it { is_expected.to validate_presence_of(:end_date) }
end
