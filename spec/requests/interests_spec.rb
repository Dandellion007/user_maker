# frozen_string_literal: true

require 'rails_helper'

RSpec.describe '/interests', type: :request do
  describe 'GET /index' do
    subject(:request) { get interests_url }

    let(:resources) { create_list(:interest, 2) }
    let(:response_body) do
      resources.map do |resource|
        {
          'id' => resource.id,
          'name' => resource.name
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
    subject(:request) { get interest_url(resource) }

    let(:resource) { create(:interest) }
    let(:response_body) do
      {
        'id' => resource.id,
        'name' => resource.name
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
    subject(:request) { post interests_url, params: }

    context 'with valid parameters' do
      let(:params) do
        {
          'name' => 'some_name'
        }
      end
      let(:response_body) { params }

      it 'creates resource' do
        expect { request }.to change(Interest, :count).by(1)
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
        expect { request }.to change(Interest, :count).by(0)
      end

      it 'renders failure response' do
        request
        expect(response).to have_http_status(:bad_request)
      end
    end
  end

  describe 'DELETE /destroy' do
    subject(:request) { delete interest_url(resource) }

    let(:resource) { create(:interest) }

    before do
      resource
    end

    it 'destroys resource' do
      expect { request }.to change(Interest, :count).by(-1)
    end

    it 'renders successful response' do
      request
      expect(response).to(have_http_status(:success))
    end
  end
end
