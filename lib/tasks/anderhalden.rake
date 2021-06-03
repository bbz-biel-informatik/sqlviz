require 'open-uri'
require 'json'
require 'pg'
require 'ostruct'

desc "Load data from fvbj into the database"
namespace :anderhalden do

  desc 'Create the necessary tables'
  task :prepare do
    sql = File.read(File.join(File.dirname(__FILE__), 'anderhalden.sql'))
    db = PG::Connection.new(ENV['DATABASE_URL'])
    db.exec(sql)
    db.exec("INSERT INTO data_stock_symbols (name) VALUES ('BTC-USD'), ('ETH-USD');")
  end

  desc 'Get btc stock price'
  task :import_btc do
    url = "https://finnhub.io/api/v1/quote?symbol=COINBASE:BTC-USD&token=#{ENV['FINNHUB_API_TOKEN']}"
    str = URI.parse(url).read
    obj = JSON.parse(str)
    price = obj['c']
    db = PG::Connection.new(ENV['DATABASE_URL'])
    q = "INSERT INTO data_stock_prices (date, stock_symbol_id, price) VALUES ('#{DateTime.current.strftime('%Y-%m-%d %H:%M:%S')}', 1, #{price});"
    db.exec(q)
    puts "BTC done"
  end

  desc 'Get eth stock price'
  task :import_eth do
    url = "https://finnhub.io/api/v1/quote?symbol=COINBASE:ETH-USD&token=#{ENV['FINNHUB_API_TOKEN']}"
    str = URI.parse(url).read
    obj = JSON.parse(str)
    price = obj['c']
    db = PG::Connection.new(ENV['DATABASE_URL'])
    q = "INSERT INTO data_stock_prices (date, stock_symbol_id, price) VALUES ('#{DateTime.current.strftime('%Y-%m-%d %H:%M:%S')}', 2, #{price});"
    db.exec(q)
    puts "ETH done"
  end
end
