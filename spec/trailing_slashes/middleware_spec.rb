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

    context 'when there are multiple trailing slashes' do
      before :each do
        get '/foo////'
      end

      it '301 redirects' do
        expect(last_response.status).to eql(301)
      end

      it 'redirects to location without trailing slash' do
        expect(last_response.headers['Location']).to eql('/foo')
      end

      it 'includes redirect message' do
        expected = "Redirecting to <a href=\"/foo\">/foo</a>"
        expect(last_response.body).to eql(expected)
      end
    end

    [:put, :post, :patch, :delete, :options, :head].each do |type|
      context "when a #{type} request" do
        before :each do
          send(type, '/foo/')
        end

        it 'passes thru' do
          expect(last_response.body).to include('root app')
        end
      end
    end
  end
end
