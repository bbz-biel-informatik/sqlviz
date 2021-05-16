require 'pg'
require 'csv'

desc "Load data from a CSV file into the database"
namespace :csv do
  task :load  do
    #db = PG::Connection.new(host: 'sqlviz.bbz.cloud', port: 1234, dbname: 'sqlviz_postgres', user: 'postgres', password: 'aaaa')
    db = PG::Connection.new(host: 'localhost', port: 5432, dbname: 'sqlviz_development', user: 'postgres', password: 'postgres')
    rows = CSV.read('/home/lukasdiener/Code/bbz/sqlviz/samples/test.csv', headers: true)
    rows.each do |row|
      query = "INSERT INTO data_humidity (date, location, value) VALUES ('#{row['date']}', '#{row['location']}', #{row['value']});"
      if ENV['WRITE'] == '1'
        db.exec(query)
      else
        puts query
      end
    end
  end
end
