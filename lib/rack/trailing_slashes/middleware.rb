module Rack::TrailingSlashes
  class Middleware
    def call(env)
      [200, {}, '']
    end
  end
end
