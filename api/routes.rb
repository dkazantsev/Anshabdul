module Anshabdul
  class Routes < Grape::API

    require 'pry'

    get '/ping' do

      # g = EM::HttpRequest.new("http://google.com/index.html").get
      # puts "Received #{g.response_header.status} from Google"

      # [200, {'X-Goliath' => 'Proxy'}, g.response]

      binding.pry
    end


    post '/keystone/token' do
      error!("Missing parameters", 500) unless params[:account_id].present? and params[:group_id].present?

      # uid and gid regex

      # DB.where(account_id = $1 and group_id = $2, params[:account_id], params[:group_id])
      # sleep(1)

      # keystone_user_id = db.result.keystone_user_id
      keystone_user_id = nil

      unless keystone_user_id
        keystone_user_id = Anshabdul::Keystone.create_user_keystone
        Anshabdul::Storage.create_user_db(keystone_user_id, params[:account_id], params[:group_id])
      end

      keystone_user_id ||= '3eb0268cc3124d158b4d98750304c2e6'

      Anshabdul::Keystone.request_token(keystone_user_id)
    end

  end
end

