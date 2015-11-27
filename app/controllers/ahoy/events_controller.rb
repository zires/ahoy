module Ahoy
  class EventsController < Ahoy::BaseController
    def create
      events =
        if params[:name]
          # legacy API
          [params]
        else
          begin
            ActiveSupport::JSON.decode(request.body.read)
          rescue ActiveSupport::JSON.parse_error
            # do nothing
            []
          end
        end

      events.each do |event|
        time = Time.zone.parse(event["time"]) rescue nil

        # timestamp is deprecated
        time ||= Time.zone.at(event["time"].to_f) rescue nil

        options = {
          id: event["id"],
          time: time
        }

        properties = event["properties"] || {}
        if cookies.signed[:_utm].present?
          properties[:_utm] = JSON.parse cookies.signed[:_utm]
        end

        ahoy.track event["name"], properties, options
      end
      render json: {}
    end
  end
end
