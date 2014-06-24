module Anshabdul
  module Storage

    class << self

      def config(config)
        @@conn = EM::Synchrony::ConnectionPool.new(size: 20) do
          ::Mysql2::EM::Client.new(config)
        end
      end

      def find_user_db(account_id, group_id)
        @@conn.query(
          "select * from users where account_id = %s and group_id = %s limit 1",
          [account_id, group_id])
      end

      def create_user_db(keystone_user_id, account_id, group_id)
        
      end

    end

  end
end
