require 'rails_helper'

RSpec.describe FipeService, type: :service do
  describe '#call' do
    context 'when the params are correct' do
      subject { described_class.call('Audi', 'Q5', '2017') }

      it 'return a api element' do
        is_expected.to be_a FipeApi::FipeResult
      end

      it 'return ' do
        is_expected.to have_attributes(
          id: '008186-8',
          authentication: 'jcs6wr4rm4c3j',
          fuel: 'Gasolina'
        )
      end
    end

    context 'when the params are incorrect' do
      subject { described_class.call('Audi', 'audi', '2017') }

      it 'return a api element' do
        is_expected.to match 'incorret params'
      end
    end    
  end
end
