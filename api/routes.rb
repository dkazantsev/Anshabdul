module Anshabdul
  class Routes < Grape::API

    require 'pry'

    get '/ping' do

      g = EM::HttpRequest.new("http://google.com/index.html").get
      puts "Received #{g.response_header.status} from Google"

      [200, {'X-Goliath' => 'Proxy'}, g.response]
    end


    # get '/cities' do
    #   # binding.pry

    #   Fiber.new do
    #     @results = Anshabdul::DBLayer.async_query('select * from cities')

    #     print "Server said: "
    #     @results.each { |res| puts res.values.inspect }
    #   end.resume

    #   { result: "ok" }
    # end

  end
end

