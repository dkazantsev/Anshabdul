module Anshabdul
  class Routes < Grape::API

    require 'pry'

    post '/keystone/token' do
      account_id, group_id = params[:account_id], params[:group_id]

      error!("Bad request", 500) unless (account_id =~ /\A[\dabcdef]+\z/ and group_id =~ /\A[\dabcdef]+\z/)

      user = Anshabdul::Storage.find_user_db(account_id, group_id)

      binding.pry

      # rememer about cocurrency

      unless user
        keystone_user_id = Anshabdul::Keystone.create_user_keystone
        user = Anshabdul::Storage.create_user_db(account_id, group_id, keystone_user_id)
      end

      Anshabdul::Keystone.request_token(user.keystone_user_id)
    end

  end
end

