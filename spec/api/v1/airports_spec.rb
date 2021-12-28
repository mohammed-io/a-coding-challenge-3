require 'rails_helper'

RSpec.describe 'API::V1::AirportsController', type: :request do
  describe 'show' do
    before do
      %i[fra muc zrh vie inn grz].each { |iata| create(:airport, iata) }
    end

    context "filtered" do
      subject(:airports_request) do
        json_get api_v1_airports_url, params: {countries: ['XX']}
      end

      it 'returns 1 airport' do
        create(:airport, iata: 'foo', country_alpha2: 'XX')
        airports_request

        expect(response.status).to eq(200)
        expect(JSON.parse(json[:data]).size).to eq(1)
      end
    end

    context "unfiltered" do
      subject(:airports_request) { json_get api_v1_airports_url }

      it 'returns airports', :aggregate_failures do
        airports_request

        expect(response.status).to eq(200)
        expect(JSON.parse(json[:data]).size).to eq(6)
      end
    end

    context "paginated" do
      subject(:airports_request) { json_get api_v1_airports_url, params: {per_page: 1} }

      it 'returns airports', :aggregate_failures do
        airports_request

        expect(response.status).to eq(200)
        expect(JSON.parse(json[:data]).size).to eq(1)
      end
    end
  end
end
