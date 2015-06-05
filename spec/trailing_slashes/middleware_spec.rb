require 'spec_helper'

module Rack::TrailingSlashes
  describe Middleware do
    include Rack::Test::Methods

    def app
      described_class.new(root_app)
    end

    def root_app
      lambda { |env| [200, {}, "root app"] }
    end

    context 'when there is no trailing slash' do
      it 'passes thru' do
        get ''
        expect(last_response.body).to include('root app')
      end
    end
  end
end
