require 'pagy/extras/metadata'

module API
  module V1
    class AirportsController < BaseController
      include Pagy::Backend

      before_action :set_airports

      def index
        render json: {
          data: AirportSerializer.render(@airports),
          pagination: pagy_metadata(@airports_pagy)
        }
      end

      private
      def set_airports
        @airports_pagy, @airports = pagy(Airport
                      .by_country(params[:countries])
                      .order_by_size, items: params[:per_page])
      end
    end
  end
end
