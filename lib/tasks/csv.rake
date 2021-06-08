require 'pg'
require 'csv'

desc "Load data from a CSV file into the database"
namespace :csv do

  desc 'Create the necessary tables'
  task :prepare do
    sql = File.read(File.join(File.dirname(__FILE__), 'csv.sql'))
    db = PG::Connection.new(ENV['DATABASE_URL'])
    db.exec(sql)
  end

  task :bern_zollikofen  do
    db = PG::Connection.new(ENV['DATABASE_URL'])
    file = Rails.root.join('samples', 'bern_zollikofen.csv')
    rows = CSV.read(file, headers: true, col_sep: ";")
    rows.each do |row|
      query = "INSERT INTO data_bern_zollikofen (jahr, monat, temperatur, niederschlag) VALUES (#{row['jahr']}, #{row['monat']}, #{row['temperatur']}, #{row['niederschlag']});"
      if ENV['WRITE'] == '1'
        puts query
        db.exec(query)
      else
        puts query
      end
    end
  end

  task :rhein  do
    db = PG::Connection.new(ENV['DATABASE_URL'])
    file = Rails.root.join('samples', 'Rheinmesswerte.csv')
    rows = CSV.read(file, headers: true, col_sep: ";")
    queries = []
    rows.each do |row|
      queries << "INSERT INTO data_rhein (start, ende, elektrische_leitfaehigkeit, sauerstoffgehalt, ph, temperatur) VALUES ('#{row['startzeitpunkt']}', '#{row['endezeitpunkt']}', #{row['elektrische_leitfaehigkeit'] || 'NULL'}, #{row['sauerstoffgehalt'] || 'NULL'}, #{row['ph'] || 'NULL'}, #{row['temperatur'] || 'NULL'});"
    end

    if ENV['WRITE'] == '1'
      queries.each_slice(1000) do |q|
        puts q.join("\n")
        db.exec(q.join("\n"))
      end
    else
      puts queries.join("\n")
    end
  end

  task :aare  do
    db = PG::Connection.new(ENV['DATABASE_URL'])
    file = Rails.root.join('samples', 'data_aare.csv')
    rows = CSV.read(file, headers: true, col_sep: ",")
    queries = []
    rows.each do |row|
      queries << "INSERT INTO data_aare (datum, abfluss, pegel, sauerstoffgehalt, temperatur) VALUES ('#{row['Zeitstempel']}', #{row['Abfluss'] || 'NULL'}, #{row['Pegel'] || 'NULL'}, #{row['Sauerstoff'] || 'NULL'}, #{row['Temperatur'] || 'NULL'});"
    end

    if ENV['WRITE'] == '1'
      queries.each_slice(1000) do |q|
        puts q.join("\n")
        db.exec(q.join("\n"))
      end
    else
      puts queries.join("\n")
    end
  end

  task :kanton  do
    db = PG::Connection.new(ENV['DATABASE_URL'])
    file = Rails.root.join('samples', 'kantone.csv')
    rows = CSV.read(file, headers: true, col_sep: ",")
    rows.each do |row|
      query = "INSERT INTO data_kanton (kuerzel, name) VALUES ('#{row['kuerzel']}', '#{row['name']}');"
      if ENV['WRITE'] == '1'
        puts query
        db.exec(query)
      else
        puts query
      end
    end
  end

  task :solar  do
    db = PG::Connection.new(ENV['DATABASE_URL'])
    file = Rails.root.join('samples', 'Solarenergiepotenziale.csv')
    rows = CSV.read(file, headers: true, col_sep: ",")
    queries = []
    rows.each do |row|
      queries << "INSERT INTO data_solar (gemeinde, Scenario1_RoofsOnly, Scenario2_RoofsOnly, Scenario3_RoofsFacades, Scenario4_RoofsFacades, kanton_id) VALUES ('#{row['MunicipalityName'].gsub("'", " ")}', #{row['Scenario1_RoofsOnly_PotentialSolarElectricity_GWh']}, #{row['Scenario2_RoofsOnly_PotentialSolarElectricity_GWh']}, #{row['Scenario3_RoofsFacades_PotentialSolarElectricity_GWh']}, #{row['Scenario4_RoofsFacades_PotentialSolarElectricity_GWh']}, #{row['kanton_id']});"
    end

    if ENV['WRITE'] == '1'
      queries.each_slice(1000) do |q|
        puts q.join("\n")
        db.exec(q.join("\n"))
      end
    else
      puts queries.join("\n")
    end
  end

  task :todesfaelle  do
    db = PG::Connection.new(ENV['DATABASE_URL'])
    file = Rails.root.join('samples', 'Todesfaelle.csv')
    rows = CSV.read(file, headers: true, col_sep: ",")
    queries = []
    rows.each do |row|
      queries << "INSERT INTO data_todesfaelle (jahr, kalenderwoche, altersgruppe, geschlecht, todesfaelle, kanton_id) VALUES ('#{row['jahr']}', #{row['kalenderwoche']}, '#{row['altersgruppe']}', '#{row['geschlecht']}', #{row['todesfaelle']}, #{row['kanton_id']});"
    end
    if ENV['WRITE'] == '1'
      queries.each_slice(1000) do |q|
        puts q.join("\n")
        db.exec(q.join("\n"))
      end
    else
      puts queries.join("\n")
    end
  end

  task :geburten  do
    db = PG::Connection.new(ENV['DATABASE_URL'])
    file = Rails.root.join('samples', 'Geburten.csv')
    rows = CSV.read(file, headers: true, col_sep: ",")
    queries = []
    rows.each do |row|
      cid = row['Kanton-ID']
      row.each_with_index do |col,idx|
        next if idx < 2
        jahr = 1968 + idx
        queries << "INSERT INTO data_geburten (jahr, geburten, kanton_id) VALUES (#{jahr}, #{row[jahr.to_s]}, #{cid});"
      end
    end
    if ENV['WRITE'] == '1'
      queries.each_slice(1000) do |q|
        puts q.join("\n")
        db.exec(q.join("\n"))
      end
    else
      puts queries.join("\n")
    end
  end

  task :luftqualitaet  do
    db = PG::Connection.new(ENV['DATABASE_URL'])
    (1983..2021).each do |year|
      file = Rails.root.join('samples', "ugz_ogd_air_d1_#{year}.csv")
      rows = CSV.read(file, headers: true, col_sep: ",")
      queries = []
      rows.each do |row|
        queries << "INSERT INTO data_luftqualitaet (datum, standort, parameter, einheit, wert) VALUES ('#{row.first.last}', '#{row['Standort']}', '#{row['Parameter']}', '#{row['Einheit']}', #{row['Wert'] || 'NULL'});"
      end
      if ENV['WRITE'] == '1'
        queries.each_slice(1000) do |q|
          puts q.join("\n")
          db.exec(q.join("\n"))
        end
      else
        puts queries.join("\n")
      end
    end
  end
end
