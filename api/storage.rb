module Anshabdul
  module Storage

    class << self

      def config(config)
        @@config

        instance_eval %{
          @@username = config["username"]
          @@password = config["password"]
        }
      end


      def find_user_db(account_id, group_id)
        user = User.where(account_id: account_id, group_id: group_id).first        
        return nil unless user
        
        {username: user["keystone_user"], password: user["keystone_pass"]}
      end
      

      def create_user_db(account_id, group_id, keystone_user, keystone_pass)
        User.create!(
          account_id: account_id,
          group_id: group_id,
          keystone_user: keystone_user,
          keystone_pass: keystone_pass
        )
      rescue
        nil
      end


      def create_billing_db(db_name)
        options = {charset: 'utf8', collation: 'utf8_unicode_ci'}

        config = @@config.dup.symbolize_keys
        config.merge!(database: db_name)

        ActiveRecord::Base.establish_connection(config.except(:database))
        ActiveRecord::Base.connection.create_database(db_name, options)
        ActiveRecord::Base.establish_connection(config)

        ActiveRecord::Base.connection.execute(
          'create table `usage` (account_id varchar(255), group_id varchar(255));')

        ActiveRecord::Base.connection.close
      rescue
        nil
      end

    end

  end
end
