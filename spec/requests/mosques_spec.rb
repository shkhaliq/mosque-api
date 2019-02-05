require 'rails_helper'

RSpec.describe 'Mosques API', type: :request do
  # initialize test data 
  let!(:mosques) { create_list(:mosque, 10) }
  let(:mosque_id) { mosques.first.id }

  # Test suite for GET /mosques
  describe 'GET /mosques' do
    # make HTTP get request before each example
    before { get '/mosques' }

    it 'returns mosques' do
      # Note `json` is a custom helper to parse JSON responses
      expect(json).not_to be_empty
      expect(json.size).to eq(10)
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end
  end

  # Test suite for GET /mosques/:id
  describe 'GET /mosques/:id' do
    before { get "/mosques/#{mosque_id}" }

    context 'when the record exists' do
      it 'returns the mosque' do
        expect(json).not_to be_empty
        expect(json['id']).to eq(mosque_id)
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end

    context 'when the record does not exist' do
      let(:mosque_id) { 100 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match("{\"message\":\"Couldn't find Mosque with 'id'=100\"}")
      end
    end
  end

  # Test suite for POST /mosques
  describe 'POST /mosques' do
    # valid payload
    let(:valid_attributes) { { name: 'Baitul Mukarram' } }

    context 'when the request is valid' do
      before { post '/mosques', params: valid_attributes }

      it 'creates a mosque' do
        expect(json['name']).to eq('Baitul Mukarram')
      end

      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end
    end

    context 'when the request is invalid' do
      before { post '/mosques', params: { name: '' } }

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end

      it 'returns a validation failure message' do
        expect(response.body)
          .to match(/Validation failed: Name can't be blank/)
      end
    end
  end

  # Test suite for PUT /mosques/:id
  describe 'PUT /mosques/:id' do
    let(:valid_attributes) { { name: 'SomeMosque' } }

    context 'when the record exists' do
      before { put "/mosques/#{mosque_id}", params: valid_attributes }

      it 'updates the record' do
        expect(response.body).to be_empty
      end

      it 'returns status code 204' do
        expect(response).to have_http_status(204)
      end
    end
  end

  # Test suite for DELETE /mosques/:id
  describe 'DELETE /mosques/:id' do
    before { delete "/mosques/#{mosque_id}" }

    it 'returns status code 204' do
      expect(response).to have_http_status(204)
    end
  end
end