# module Anshabdul
#   class DBLayer
#     include EM::Deferrable

#     class << self

#       def configure(db)
#         # prepare params
#         conn_opts = db.except("timeout", "nonblock")

#         # connecting
#         @@conn = PG.connect(conn_opts) or raise "Unable to create a new connection!"
#         @@conn.status == PG::CONNECTION_OK or raise "Connect failed: #{conn.error_message}"

#         @@conn.setnonblocking( db["nonblock"] )
#         @@socket = @@conn.socket_io

#         # define class methods and costant
#         instance_eval %{
#           def conn
#             @@conn
#           end

#           def socket
#             @@socket
#           end
#         }

#         class_eval %{
#           TIMEOUT = db["timeout"].freeze
#         }
#       end

#       def async_query(query)
#         f = Fiber.current

#         data = new(query)
#         data.callback { |results| f.resume(results) }
#         data.errback { |results| f.resume(results) }

#         return Fiber.yield
#       end

#     end


#     def initialize(query)
#       consume_loop = lambda do
#         # send query and immediately returns
#         @@conn.send_query(query)

#         results = []

#         # check for results while they are present
#         loop do
#           # buffering
#           @@conn.consume_input

#           while @@conn.is_busy
#             select([@@socket], nil, nil, TIMEOUT) or raise "Timeout waiting for query response."
            
#             # todo raise -> fail
#             @@conn.consume_input
#           end

#           # get query result
#           result = @@conn.get_result
#           if result
#             results << result
#           else
#             break
#           end
#         end

#         results
#       end

#       callback = lambda do |results|
#         if results and results.kind_of?(Array)
#           succeed(results)
#         else
#           fail(results)
#         end
#       end

#       EM.defer(consume_loop, callback)
#     end

#   end
# end

