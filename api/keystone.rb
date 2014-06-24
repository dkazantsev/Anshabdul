module Anshabdul
  module Keystone

    class << self

      def config(config)
        config.each do |key, val|
          instance_eval "@@#{key} = '#{val}'"
        end
      end

      # various functions
      

      def create_user_keystone
        return {username: SecureRandom.hex(4), password: SecureRandom.hex(10)}

        uri = "http://#{@@host}:#{@@port}/#{@@api}/users"

        head = {:"Content-Type" => "application/json", :"X-Auth-Token" => @@token}

        credentials = {username: SecureRandom.hex(4), password: SecureRandom.hex(10)}
        
        body = {:user => {
          :name => credentials[:username],
          :enabled => true,
          :"OS-KSADM:password" => credentials[:password]
        }}        

        http = EM::HttpRequest.new(uri).post body: body, head: head

        response = JSON.parse(http.response)

        p response

        error!("Unable to add user", 500) unless response["user"] and response["user"]["id"]

        credentials
      end

      def request_token(user)
        return {token: 'ad34235efdf'}

        uri = "http://#{@@host}:#{@@port}/#{@@api}/tokens"

        head = {:"Content-Type" => "application/json"}

        # FIXME: delete tenant

        body = {auth: {
          tenantName: 'admin',
          passwordCredentials: {username: 'admin', password: 'qwerty'}
        }}
        
        http = EM::HttpRequest.new(uri).post body: body, head: head

        response = JSON.parse(http.response)

        p response

        {token: response["access"]["token"]["id"]}
      end

    end

  end
end
