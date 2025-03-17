# frozen_string_literal: true

require 'rails_helper'

RSpec.describe '/users', type: :request do
  describe 'GET /index' do
    subject(:request) { get users_url }

    let(:resources) { create_list(:user, 2) }
    let(:response_body) do
      resources.map do |resource|
        {
          'age' => resource.age,
          'name' => resource.name,
          'patronymic' => resource.patronymic,
          'email' => resource.email,
          'nationality' => resource.nationality,
          'country' => resource.country,
          'gender' => resource.gender,
          'surname' => resource.surname,
          'skills' => [],
          'interests' => []
        }
      end
    end

    before do
      resources
    end

    it 'renders successful response' do
      request
      expect(response).to(have_http_status(:success))
      expect(JSON.parse(response.body)).to match_array(response_body)
    end
  end

  describe 'GET /show' do
    subject(:request) { get user_url(resource) }

    let(:resource) { create(:user) }
    let(:response_body) do
      {
        'age' => resource.age,
        'name' => resource.name,
        'patronymic' => resource.patronymic,
        'email' => resource.email,
        'nationality' => resource.nationality,
        'country' => resource.country,
        'gender' => resource.gender,
        'surname' => resource.surname,
        'skills' => [],
        'interests' => []
      }
    end

    before do
      request
    end

    it 'renders successful response' do
      expect(response).to(have_http_status(:success))
      expect(JSON.parse(response.body)).to eq(response_body)
    end
  end

  describe 'POST /create' do
    subject(:request) { post users_url, params: }

    let(:base_params) do
      {
        'email' => 'sherlyn@goldner.example',
        'age' => 7,
        'gender' => 'male',
        'name' => 'Ahmed',
        'surname' => 'Weber',
        'patronymic' => 'Emard',
        'nationality' => 'Czechs',
        'country' => 'United Arab Emirates'
      }
    end

    context 'with valid parameters' do
      let(:params) { { 'params' => base_params } }
      let(:response_body) { base_params }

      it 'creates resource' do
        expect { request }.to change(User, :count).by(1)
      end

      it 'renders successful response' do
        request
        expect(response).to(have_http_status(:success))
        expect(JSON.parse(response.body)).to include(response_body)
      end
    end

    context 'with params contain interests' do
      let(:interest) { create(:interest) }
      let(:params) { { 'params' => base_params.merge('interests' => [interest.name]) } }
      let(:response_body) do
        base_params.merge(
          'interests' => [{
            'id' => interest.id,
            'name' => interest.name
          }]
        )
      end

      it 'creates resource' do
        expect { request }.to change(User, :count).by(1)
      end

      it 'renders successful response' do
        request
        expect(response).to(have_http_status(:success))
        expect(JSON.parse(response.body)).to include(response_body)
      end
    end

    context 'with params contain skills' do
      let(:skill) { create(:skill) }
      let(:skills) { skill.name }
      let(:params) { { 'params' => base_params.merge('skills' => skills) } }
      let(:response_body) do
        base_params.merge(
          'skills' => [{
            'id' => skill.id,
            'name' => skill.name
          }]
        )
      end

      it 'creates resource' do
        expect { request }.to change(User, :count).by(1)
      end

      it 'renders successful response' do
        request
        expect(response).to(have_http_status(:success))
        expect(JSON.parse(response.body)).to include(response_body)
      end
    end

    context 'with invalid parameters' do
      let(:params) { {} }

      it 'does not create resource' do
        expect { request }.to change(User, :count).by(0)
      end

      it 'renders failure response' do
        request
        expect(response).to have_http_status(:bad_request)
      end
    end
  end

  describe 'DELETE /destroy' do
    subject(:request) { delete user_url(resource) }

    let(:resource) { create(:user) }

    before do
      resource
    end

    it 'destroys resource' do
      expect { request }.to change(User, :count).by(-1)
    end

    it 'renders successful response' do
      request
      expect(response).to(have_http_status(:success))
    end
  end
end
