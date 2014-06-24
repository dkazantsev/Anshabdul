module Anshabdul
  module Keystone

    class << self

      def config(config)
        config.each do |key, val|
          instance_eval "@@#{key} = '#{val}'"
        end
      end


      def create_user_keystone
        uri = "http://#{@@host}:#{@@port}/#{@@api}/users"

        head = {:"Content-Type" => "application/json", :"X-Auth-Token" => @@token}

        credentials = {username: SecureRandom.hex(4), password: SecureRandom.hex(10)}
        
        body = {:user => {
          :name => credentials[:username],
          :enabled => true,
          :"OS-KSADM:password" => credentials[:password]
        }}        

        http = EM::HttpRequest.new(uri).post body: JSON(body), head: head

        response = JSON.parse(http.response)

        return nil unless response["user"] and response["user"]["id"]

        credentials
      end


      def request_token(user)
        uri = "http://#{@@host}:#{@@port}/#{@@api}/tokens"

        head = {:"Content-Type" => "application/json"}

        body = {auth: {passwordCredentials: {username: 'admin', password: 'qwerty'}}}
        
        http = EM::HttpRequest.new(uri).post body: JSON(body), head: head

        response = JSON.parse(http.response)

        {token: response["access"]["token"]["id"]}
      end

    end

  end
end
