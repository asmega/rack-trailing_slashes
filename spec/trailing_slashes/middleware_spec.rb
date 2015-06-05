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

    context 'when root path' do
      it 'passes thru' do
        get '/'
        expect(last_response.body).to include('root app')
      end
    end

    context 'when there is no trailing slash' do
      it 'passes thru' do
        get '/foo'
        expect(last_response.body).to include('root app')
      end
    end

    context 'when there is a trailing slash' do
      it '301 redirects' do
        get '/foo/'
        expect(last_response.status).to eql(301)
      end

      it 'redirects to location without trailing slash' do
        get '/foo/'
        expect(last_response.headers['Location']).to eql('/foo')
      end

      it 'includes redirect message' do
        get '/foo/'
        expected = "Redirecting to <a href=\"/foo\">/foo</a>"
        expect(last_response.body).to eql(expected)
      end
    end
  end
end
