require 'rails_helper'

RSpec.describe "Cars", type: :request do
  let(:user) { create(:user) }
  let!(:login) { login_as(user) }

  describe 'GET #index' do
    let!(:cars) { FactoryBot.create_list(:car, 6) }

    before { get cars_path }

    it { is_expected.to render_template(:index) }

    it { expect(response).to be_successful }

    it { expect(assigns(:cars).count).to eq 6 }
  end

  describe 'GET #new' do
    before { get new_car_path }

    it { expect(response).to render_template(:new) }

    it 'initializing a new car' do
      expect(assigns(:car)).to be_a Car
    end
  end
  
  describe 'GET #show' do
    let(:car) { create(:car) }
    before { get car_path(car) }

    it { expect(response).to render_template(:show) }

    it 'initializing a new car' do
      expect(assigns(:car)).to have_attributes(
          model: car.model,
          manufacture: car.manufacture,
          license_plate: car.license_plate,
          model_year: car.model_year,
          manufacture_year: car.manufacture_year,
          fuel_type: car.fuel_type,
          color: car.color
        )
    end
  end

  describe 'POST #create' do
    subject { post cars_path, params: { car: params } }

    context 'with invalid params' do
      let(:params) { attributes_for(:car, model: '') }

      it 'should not create an car' do
        expect { subject }.not_to change(Car, :count)
      end
    end

    context 'with valid params' do
      let(:params) do
        {
          model: 'Fusca',
          manufacture: 'Volkswagen',
          license_plate: 'ABC-1234',
          model_year: '1984',
          manufacture_year: '1982',
          fuel_type: 'Gasoline',
          color: 'Verde'
        }
      end

      it { expect { subject }.to change(Car, :count).by(1) }

      it 'creates a new car attributes' do
        subject
        expect(assigns(:car)).to have_attributes(
          model: params[:model],
          manufacture: params[:manufacture],
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
    let(:car) { create(:car) }
    before { get edit_car_path(car) }

    it { is_expected.to render_template(:edit) }

    it 'initializing the given car' do
      expect(assigns(:car)).to be_a(Car) &
        have_attributes(id: car.id)
    end
  end

  describe 'PUT #update' do
    let(:car) { create(:car) }
    subject(:update_car_path) { put car_path(car), params: { car: car_params } }

    context 'when the params are invalid' do
      let(:car_params) { { model: '', license_plate: '' } }

      it 'should not update the car' do
        expect do
          update_car_path
          car.reload
        end.not_to change(car, :model)
      end
    end

    context 'when the params are valids' do
      let(:car_params) { { license_plate: 'ABC-1234' } }

      it 'updates the license plate car' do
        expect do
          update_car_path
          car.reload
        end.to change(car, :license_plate).to(car_params[:license_plate])
      end
    end
  end

  describe 'DELETE #destroy' do
    let!(:cars) { FactoryBot.create_list(:car, 5) }
    subject(:delete_car_path) { delete car_path(cars.first.id) }

    it 'delete the car' do
      expect { delete_car_path }.to change(Car, :count).by(-1)
    end
  end
end
