require 'rails_helper'

RSpec.describe "Rents", type: :request do
  describe 'GET #new' do
    let(:vehicle) { create(:vehicle) }
    before { get new_rent_path(vehicle: vehicle) }

    it { is_expected.to render_template(:new) }

    it { expect(response).to be_successful }

    it { expect(assigns(:rent)).to be_a Rent }
  end

  describe 'POST #create' do
    let(:vehicle) { create(:vehicle) }
    subject { post rents_path, params: { rent: params } }

    context 'with invalid params' do
      let(:params) { attributes_for(:rent, cpf: '', vehicle_id: vehicle.id) }

      it 'should not create an rent' do
        expect { subject }.not_to change(Rent, :count)
      end
    end

    context 'with start_date before today' do
      let(:params) do
        {
          vehicle_id: vehicle.id,
          cpf: '12345678912',
          start_date: (Date.current - 1.day).to_s,
          end_date: (Date.current + 1.day).to_s
        }
      end

      it { expect { subject }.not_to change(Rent, :count) }   
    end

    context 'with end_date before start_date' do
      let(:params) do
        {
          vehicle_id: vehicle.id,
          cpf: '12345678912',
          start_date: (Date.current + 10.day).to_s,
          end_date: (Date.current + 1.day).to_s
        }
      end

      it { expect { subject }.not_to change(Rent, :count) }   
    end       

    context 'with valid params' do
      let(:params) do
        {
          vehicle_id: vehicle.id,
          cpf: '12345678912',
          start_date: (Date.current + 10.day).to_s,
          end_date: (Date.current + 15.day).to_s
        }
      end

      it { expect { subject }.to change(Rent, :count).by(1) }

      it 'creates a new rent attributes' do
        subject
        expect(assigns(:rent)).to have_attributes(
          vehicle_id: params[:vehicle_id],
          cpf: params[:cpf],
          start_date: params[:start_date].to_date,
          end_date: params[:end_date].to_date
        )
      end
    end

    context 'with a date already rented with the same car' do
      let!(:rent) { create(:rent, vehicle: vehicle, start_date: Date.current + 1.day) }
      let(:params) do
        {
          vehicle_id: vehicle.id,
          cpf: '12345678912',
          start_date: (Date.current + 1.day).to_s,
          end_date: (Date.current + 10.day).to_s
        }
      end

      it { expect { subject }.not_to change(Rent, :count) }   
    end       
  end

  describe 'GET #show' do
    let(:rent) { create(:rent) }
    before { get rent_path(rent) }

    it { expect(response).to render_template(:show) }

    it 'initializing a new rent' do
      expect(assigns(:rent)).to have_attributes(
          cpf: rent.cpf,
          start_date: rent.start_date,
          end_date: rent.end_date
        )
    end
  end
end