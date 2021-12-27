module API
  module V1
    class AirportsController < BaseController
      before_action :set_airports
      def index
        render json: @airports
      end

      private
      def set_airports
        @airports = Airport
                      .by_country(params[:countries])
                      .order_by_size
      end
    end
  end
end
