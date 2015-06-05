module Rack::TrailingSlashes
  class Middleware
    def initialize(app)
      @app = app
    end

    def call(env)
      if env['PATH_INFO'].match /(.+)\/$/
        desired_path = $1
        [301, {'Location' => desired_path}, redirect_message(desired_path)]
      else
        @app.call(env)
      end
    end

    private

    def redirect_message(location)
      "Redirecting to <a href=\"#{location}\">#{location}</a>"
    end
  end
end
