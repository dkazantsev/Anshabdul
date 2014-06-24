module Anshabdul
  module Storage

    class << self

      def config(config)
        @@conn = EM::Synchrony::ConnectionPool.new(size: 20) do
          ::Mysql2::EM::Client.new(config)
        end
      end

      def find_user_db(account_id, group_id)
        user = @@conn.query(
          "select * from users where account_id = '%s' and group_id = '%s' limit 1" % 
          [account_id, group_id])
        
        return nil unless user.first.present?
        
        {username: user.first["keystone_user"], password: user.first["keystone_pass"]}
      end

      def create_user_db(account_id, group_id, keystone_user, keystone_pass)
        @@conn.query(
          "insert into users values ('%s', '%s', '%s', '%s')" % 
          [account_id, group_id, keystone_user, keystone_pass])
      end

    end

  end
end
