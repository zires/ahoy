module Ahoy
  class Tracker

    def initialize(options = {})
      @visit = options[:visit]
      @user = options[:user]
    end

    def track(name, properties)
      Ahoy.event_model.create! do |e|
        e.visit = @visit
        e.user = @user
        e.name = name
        e.properties = properties
        e.time = Time.now
      end
    end

  end
end
