module Anshabdul
  class Routes < Grape::API
    # format :json

    get '/ping' do
      g = EM::HttpRequest.new("http://google.com/index.html").get
      puts "Received #{g.response_header.status} from Google"

      [200, {'X-Goliath' => 'Proxy'}, g.response]
    end

  end
end

