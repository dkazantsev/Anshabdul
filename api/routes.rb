module Anshabdul
  class Routes < Grape::API

    post '/keystone/token' do
      account_id, group_id = params[:account_id], params[:group_id]

      # Check uid and gid for presense and hex format
      error!("Bad request", 500) unless (account_id =~ /\A[\dabcdef]+\z/ and group_id =~ /\A[\dabcdef]+\z/)

      # Look for user in local database, load his username and password
      credentials = Anshabdul::Storage.find_user_db(account_id, group_id)

      unless credentials
        # If user not found then create
        # First tell Keystone to create new one
        # Then load his (obviously) new credentials
        credentials = Anshabdul::Keystone.create_user_keystone

        error!("Unable to add user", 500) unless credentials

        # Store uid, gid and random generated credentials as user record
        error!("Duplicate user", 500) unless Anshabdul::Storage.create_user_db(
          account_id, group_id, credentials[:username], credentials[:password])

        # Run shell script to create user's personal storage
        Anshabdul::Storage.create_billing_db(credentials[:username])
      end

      # Ask Keystone for temporary token
      Anshabdul::Keystone.request_token(credentials)
    end

  end
end

