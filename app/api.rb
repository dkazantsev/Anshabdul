module Anshabdul
  class API < Grape::API
    prefix 'api'
    format :json
    
    mount ::Anshabdul::Routes
  end
end

