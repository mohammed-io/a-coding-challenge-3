# == Schema Information
#
# Table name: airports
#
#  id               :uuid             not null, primary key
#  altitude         :integer
#  city             :string
#  country          :string
#  country_alpha2   :string
#  dst              :string
#  iata             :string
#  icao             :string
#  kind             :string
#  latitude         :decimal(10, 6)
#  longitude        :decimal(10, 6)
#  name             :string
#  passenger_volume :integer
#  source           :string
#  timezone         :string
#  timezone_olson   :string
#  uid              :integer
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#
# Indexes
#
#  index_airports_on_country_alpha2          (country_alpha2)
#  index_airports_on_iata                    (iata) UNIQUE
#  index_airports_on_iata_and_icao_and_name  (iata,icao,name)
#  index_airports_on_icao                    (icao)
#  index_airports_on_name                    (name)
#  index_airports_on_passenger_volume        (passenger_volume)
#
require 'rails_helper'

RSpec.describe Airport, type: :model do
  let!(:airport1) { create(:airport, iata: 'a', country_alpha2: 'XX', passenger_volume: 100) }
  let!(:airport2) { create(:airport, iata: 'b', country_alpha2: 'YY', passenger_volume: 1000) }
  let!(:airport3) { create(:airport, iata: 'c', country_alpha2: 'ZZ', passenger_volume: 10) }

  it "filters by the country" do
    expect(described_class.by_country('XX')).to eq [airport1]
  end

  it "returns all the countries if no country" do
    expect(described_class.by_country(nil).count).to eq 3
  end

  it "orders by the size" do
    expect(described_class.order_by_size).to eq [airport2, airport1, airport3]
  end
end
