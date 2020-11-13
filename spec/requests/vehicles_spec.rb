require 'rails_helper'

RSpec.describe "Vehicles", type: :request do
  let(:user) { create(:user) }
  let!(:login) { login_as(user) }

  describe 'GET #index' do
    let!(:vehicles) { FactoryBot.create_list(:vehicle, 6) }

    before { get vehicles_path }

    it { is_expected.to render_template(:index) }

    it { expect(response).to be_successful }

    it { expect(assigns(:vehicles).count).to eq 6 }
  end

  describe 'GET #new' do
    before { get new_vehicle_path }

    it { expect(response).to render_template(:new) }

    it 'initializing a new vehicle' do
      expect(assigns(:vehicle)).to be_a Vehicle
    end
  end
  
  describe 'GET #show' do
    let(:vehicle) { create(:vehicle) }
    before { get vehicle_path(vehicle) }

    it { expect(response).to render_template(:show) }

    it 'initializing a new vehicle' do
      expect(assigns(:vehicle)).to have_attributes(
          model: vehicle.model,
          manufacture: vehicle.manufacture,
          license_plate: vehicle.license_plate,
          model_year: vehicle.model_year,
          manufacture_year: vehicle.manufacture_year,
          fuel_type: vehicle.fuel_type,
          color: vehicle.color
        )
    end
  end

  describe 'POST #create' do
    subject { post vehicles_path, params: { vehicle: params } }

    context 'with invalid params' do
      let(:params) { attributes_for(:vehicle, model: '') }

      it 'should not create an vehicle' do
        expect { subject }.not_to change(Vehicle, :count)
      end
    end

    context 'with valid params' do
      let(:params) do
        {
          model: 'Q5',
          manufacture: 'Audi',
          license_plate: 'ABC-1234',
          model_year: '2017',
          manufacture_year: '2017',
          fuel_type: 'Gasoline',
          color: 'Verde'
        }
      end

      it { expect { subject }.to change(Vehicle, :count).by(1) }

      it 'creates a new vehicle attributes' do
        subject
        expect(assigns(:vehicle)).to have_attributes(
          manufacture: params[:manufacture],
          model: params[:model],
          license_plate: params[:license_plate],
          model_year: params[:model_year],
          manufacture_year: params[:manufacture_year],
          fuel_type: params[:fuel_type],
          color: params[:color]
        )
      end
    end
  end

  describe 'GET #edit' do
    let(:vehicle) { create(:vehicle) }
    before { get edit_vehicle_path(vehicle) }

    it { is_expected.to render_template(:edit) }

    it 'initializing the given vehicle' do
      expect(assigns(:vehicle)).to be_a(Vehicle) &
        have_attributes(id: vehicle.id)
    end
  end

  describe 'PUT #update' do
    let(:vehicle) { create(:vehicle) }
    subject(:update_vehicle_path) { put vehicle_path(vehicle), params: { vehicle: vehicle_params } }

    context 'when the params are invalid' do
      let(:vehicle_params) { { model: '', license_plate: '' } }

      it 'should not update the vehicle' do
        expect do
          update_vehicle_path
          vehicle.reload
        end.not_to change(vehicle, :model)
      end
    end

    context 'when the params are valids' do
      let(:vehicle_params) { { license_plate: 'ABC-1234' } }

      it 'updates the license plate vehicle' do
        expect do
          update_vehicle_path
          vehicle.reload
        end.to change(vehicle, :license_plate).to(vehicle_params[:license_plate])
      end
    end
  end

  describe 'DELETE #destroy' do
    let!(:vehicles) { FactoryBot.create_list(:vehicle, 5) }
    subject(:delete_vehicle_path) { delete vehicle_path(vehicles.first.id) }

    it 'delete the vehicle' do
      expect { delete_vehicle_path }.to change(Vehicle, :count).by(-1)
    end
  end
end
