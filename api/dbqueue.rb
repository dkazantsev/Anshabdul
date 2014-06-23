# module Anshabdul
#   class DBQueue < EventMachine::Queue
#     @@queue = new

#     class << self

#       def push(*items)
#         @@queue.push(items)
#         perform
#       end

#       def pop(*a, &b)
#         @@queue.pop(a, &b)
#       end


#       private

#       def free?
#         @@queue.size == 0
#       end

#       def busy?
#         @@queue.size != 0
#       end

#       def perform
#         DBQueue.pop { |item| @query = item[0] }
#         raise "DBQueue error. Race condition?" unless @query

#         Fiber.new do
#           begin
#             @results = Anshabdul::DBLayer.async_query( @query )
#             print "Server said: "
#             @results.each { |res| puts res.values.inspect } # Fixme

#             return @results.first.values
#           rescue PG::UnableToSend
#             # Busy
#             DBQueue.push(@query)
#           rescue
#             $!
#           end
#         end.resume
        
#       end

#     end

#   end
# end
