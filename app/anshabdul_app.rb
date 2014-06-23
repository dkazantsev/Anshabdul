module Anshabdul
  class App < Goliath::API
    use Goliath::Rack::Params
    use Goliath::Rack::Formatters::JSON
    use Goliath::Rack::Render

    def response(env)
      Anshabdul::API.call(env)
    end
  end
end

