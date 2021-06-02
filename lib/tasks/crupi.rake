require 'open-uri'
require 'nokogiri'
require 'pg'
require 'ostruct'

desc "Load data from fvbj into the database"
namespace :crupi do
  task :import_clubs do
    url = 'https://www.fvbj-afbj.ch/fussballverband-bern-jura/verband-fvbj/vereine-fvbj.aspx'
    html = URI.parse(url).read
    doc = Nokogiri::HTML(html)
    panels = doc.css('.listeVereine')
    clubs = panels.first.css('a')
    clubs.each do |club|
      cleaned = club.text.gsub(/\u00A0/, " ")
      name = /(.*) \((\d+)\)/.match(cleaned)[1]
      num = /(.*) \((\d+)\)/.match(cleaned)[2]
      id = club.attribute('href')
      id = /\/v-(\d+)/.match(id)[1]
    end
  end

  task :import_games do
    db = PG::Connection.new(ENV['DATABASE_URL' || 'postgres://postgres:postgres@localhost:5432/sqlviz_development'])
    (0..500).each do |chunk|
      clubs = []
      games = []
      Parallel.each(0..1000, in_threads: 20) do |i|
        id = 3_000_000 + chunk * 1000 + i
        puts "Getting #{id}"
        url = "https://www.fvbj-afbj.ch/fussballverband-bern-jura/verband-fvbj/vereine-fvbj/verein-fvbj.aspx/v-1362/tg-#{id}/"
        html = URI.parse(url).read
        doc = Nokogiri::HTML(html)
        home = doc.css('.shortTeamHeim')
        guest = doc.css('.shortTeamGast')
        result = doc.css('.shortResults')
        info = doc.css('.shortSpielort')
        next if !home.first
        date = /(\d{2}\.\d{2}\.\d{4})/.match(info.first.text)[1]
        games << OpenStruct.new(date: date, home: home.first.text, guest: guest.first.text, result: result.first.text, num: id)
      end
      queries = []
      games.each do |game|
        queries << "INSERT INTO data_games (date, home, guest, result, num) VALUES (to_date('#{game.date}', 'DD.MM.YYYY'), '#{game.home}', '#{game.guest}', '#{game.result}', #{game.num});"
      end
      puts "Insert"
      queries.each_slice(1000) do |q|
        puts q.join("\n")
        db.exec(q.join("\n"))
      end
    end
  end
end
