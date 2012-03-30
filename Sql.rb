class Sql 
        def initialize() 
            ::ActiveRecord::Base.establish_connection(
            :adapter => 'jdbc',
            :driver => 'com.mysql.jdbc.Driver',
            :url => 'jdbc:mysql://thepornboutique.com/maorus_pb',
            :username => 'maorus',
            :password => 'dR2KZPOA6Cq9'
             )
        end
        
        def exec(aQuery) 
          ActiveRecord::Base.connection.execute(aQuery)
        end
end



