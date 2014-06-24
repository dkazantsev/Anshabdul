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
        # ask keystone to create new user with
        # given name, extra and password

        # better to create disabled user


        head = {:"Content-Type" => "application/json", :"X-Auth-Token" => @@token}
        body = {auth: {tenantName: 'admin', passwordCredentials: {username: 'admin', password: 'qwerty'}}}
        uri = "http://#{@@host}:#{@@port}/#{@@api}/tokens"

        # "http://0.0.0.0:9292/?q=#{uri}"
        
        http = EM::HttpRequest.new(uri).post body: body, head: head

        http.response

        # '3eb0268cc3124d158b4d98750304c2e6' # return keystone_user_id
      end

      def request_token(keystone_user_id)
        # sleep(1)

        #res = JSON.parse(smth)
        # res["access"]["token"]["id"]

        { token: 'i_am_token' }
      end

    end

  end
end
