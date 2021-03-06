require 'rails_helper'

RSpec.describe 'Salahs API' do
  # Initialize the test data
  let(:user) { create(:user) }
  let!(:mosque) { create(:mosque) }
  let!(:salahs) { create_list(:salah, 20, mosque_id: mosque.id) }
  let(:mosque_id) { mosque.id }
  let(:id) { salahs.first.id }
  let(:headers) { valid_headers }

  # Test suite for GET /mosques/:mosque_id/salahs
  describe 'GET /mosques/:mosque_id/salahs' do
    before { get "/mosques/#{mosque_id}/salahs" }

    context 'when mosque exists' do
      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end

      it 'returns all mosque salahs' do
        expect(json.size).to eq(20)
      end
    end

    context 'when mosque does not exist' do
      let(:mosque_id) { 0 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(JSON.parse(response.body)['message']).to match(/Couldn't find Mosque/)
      end
    end
  end

  # Test suite for GET /mosques/:mosque_id/salahs/:id
  describe 'GET /mosques/:mosque_id/salahs/:id' do
    before { get "/mosques/#{mosque_id}/salahs/#{id}" }

    context 'when mosque salah exists' do
      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end

      it 'returns the salah' do
        expect(json['id']).to eq(id)
      end
    end

    context 'when mosque salah does not exist' do
      let(:id) { 0 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(JSON.parse(response.body)['message']).to match(/Couldn't find Salah/)
      end
    end
  end

  # Test suite for PUT /mosques/:mosque_id/salahs
  describe 'POST /mosques/:mosque_id/salahs' do
    let(:valid_attributes) do
      { name: 'Visit Narnia', iqamah: "19840207T123456-0500" }.to_json 
    end

    context 'when request attributes are valid' do
      before { post "/mosques/#{mosque_id}/salahs", params: valid_attributes, headers: headers }

      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end
    end

    context 'when an invalid request' do
      before { post "/mosques/#{mosque_id}/salahs", params: {}, headers: headers }

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end

      it 'returns a failure message' do
        expect(response.body).to match(/Validation failed: Name can't be blank/)
      end
    end

    context 'when a duplicate name request' do
      before {  post "/mosques/#{mosque_id}/salahs", params: { name: 'Fajr', iqamah: '19840207T123456-0500' }.to_json, headers: headers  }
      before {  post "/mosques/#{mosque_id}/salahs", params: { name: 'Fajr', iqamah: '19840207213456-0500' }.to_json, headers: headers  }

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end

      it 'returns a failure message' do
        expect(response.body).to match(/Validation failed: Name has already been taken/)
      end
    end

    context 'when a duplicate date request' do
      before {  post "/mosques/#{mosque_id}/salahs", params: { name: 'Jummah 1', iqamah: '19840207T123456-0500' }.to_json, headers: headers  }
      before {  post "/mosques/#{mosque_id}/salahs", params: { name: 'Jummah 2', iqamah: '19840207T123456-0500' }.to_json, headers: headers  }

      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end
    end
  end

  # Test suite for PUT /mosques/:mosque_id/salahs/:id
  describe 'PUT /mosques/:mosque_id/salahs/:id' do
     let(:valid_attributes) do
      # send json payload
      { name: 'Zuhr' }.to_json
    end

    before { put "/mosques/#{mosque_id}/salahs/#{id}", params: valid_attributes, headers: headers }

    context 'when salah exists' do
      it 'returns status code 204' do
        expect(response).to have_http_status(204)
      end

      it 'updates the salah' do
        updated_salah = Salah.find(id)
        expect(updated_salah.name).to match(/Zuhr/)
      end
    end

    context 'when the salah does not exist' do
      let(:id) { 0 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(JSON.parse(response.body)['message']).to match(/Couldn't find Salah/)
      end
    end
  end

  # Test suite for DELETE /mosques/:id
  describe 'DELETE /mosques/:id' do
    before { delete "/mosques/#{mosque_id}/salahs/#{id}", headers: headers }

    it 'returns status code 204' do
      expect(response).to have_http_status(204)
    end
  end
end