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
#  index_airports_on_iata                    (iata) UNIQUE
#  index_airports_on_iata_and_icao_and_name  (iata,icao,name)
#  index_airports_on_icao                    (icao)
#  index_airports_on_name                    (name)
#
class Airport < ApplicationRecord
  scope :by_country, -> country { country.presence ? where(country: country) : self }
  scope :order_by_size, -> { order(passenger_volume: :desc)}
end
