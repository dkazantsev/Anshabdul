module Anshabdul
  class Routes < Grape::API

    require 'pry'

    post '/keystone/token' do
      account_id, group_id = params[:account_id], params[:group_id]

      error!("Bad request", 500) unless (account_id =~ /\A[\dabcdef]+\z/ and group_id =~ /\A[\dabcdef]+\z/)

      credentials = Anshabdul::Storage.find_user_db(account_id, group_id)

      unless credentials
        credentials = Anshabdul::Keystone.create_user_keystone

        Anshabdul::Storage.create_user_db(
          account_id, group_id, credentials[:username], credentials[:password])
      end

      Anshabdul::Keystone.request_token(credentials)
    end

  end
end

