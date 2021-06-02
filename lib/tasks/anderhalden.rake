require 'open-uri'
require 'json'
require 'pg'
require 'ostruct'

desc "Load data from fvbj into the database"
namespace :anderhalden do

  # create table data_stock_symbols (id serial primary key, name text not null);
  # create table data_stock_prices (id serial primary key, date TIMESTAMP NOT NULL, stock_symbol_id INT REFERENCES data_stock_symbols(id) not null, price float not null);
  desc 'Get btc stock price'
  task :import_btc do
    url = 'https://finnhub.io/api/v1/quote?symbol=COINBASE:BTC-USD&token=c2rm8kqad3icosepqbog'
    str = URI.parse(url).read
    obj = JSON.parse(str)
    price = obj['c']
    db = PG::Connection.new(ENV['DATABASE_URL'] || 'postgres://postgres:postgres@localhost:5432/sqlviz_development')
    q = "INSERT INTO data_stock_prices (date, stock_symbol_id, price) VALUES ('#{DateTime.current.strftime('%Y-%m-%d %H:%M:%S')}', 1, #{price});"
    db.exec(q)
    puts "BTC done"
  end

  desc 'Get eth stock price'
  task :import_eth do
    url = 'https://finnhub.io/api/v1/quote?symbol=COINBASE:ETH-USD&token=c2rm8kqad3icosepqbog'
    str = URI.parse(url).read
    obj = JSON.parse(str)
    price = obj['c']
    db = PG::Connection.new(ENV['DATABASE_URL'] || 'postgres://postgres:postgres@localhost:5432/sqlviz_development')
    q = "INSERT INTO data_stock_prices (date, stock_symbol_id, price) VALUES ('#{DateTime.current.strftime('%Y-%m-%d %H:%M:%S')}', 2, #{price});"
    db.exec(q)
    puts "ETH done"
  end
end
