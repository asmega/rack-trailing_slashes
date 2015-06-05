require 'spec_helper'

module Rack::TrailingSlashes
  describe Middleware do
    include Rack::Test::Methods

    def app
      subject
    end

    context 'when there is no trailing slash' do
      it 'passes thru' do
        get ''
      end
    end
  end
end
