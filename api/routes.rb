module Anshabdul
  class Routes < Grape::API
    format :json
    get '/ping' do
      { ping: "pong" }
    end
  end
end

