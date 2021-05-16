require 'pg'
require 'csv'

desc "Load data from a CSV file into the database"
namespace :csv do

  pw = '3b4538099b2adc65c8a92a001da8ab20'

  # Meteodaten Bern Zollikofen
  # CREATE TABLE data_bern_zollikofen (id SERIAL PRIMARY KEY, jahr INT NOT NULL, monat INT NOT NULL, temperatur FLOAT NOT NULL, niederschlag FLOAT NOT NULL);
  task :bern_zollikofen  do
    db = PG::Connection.new(host: 'sqlviz.bbz.cloud', port: 1234, dbname: 'sqlviz_postgres', user: 'postgres', password: pw)
    #db = PG::Connection.new(host: 'localhost', port: 5432, dbname: 'sqlviz_development', user: 'postgres', password: 'postgres')
    rows = CSV.read('/home/anja/Code/BBZ/sqlviz/samples/bern_zollikofen.csv', headers: true, col_sep: ";")
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

  # Wasserdaten Rhein
  # CREATE TABLE data_rhein (id SERIAL PRIMARY KEY, start DATE NOT NULL, ende DATE NOT NULL, elektrische_leitfaehigkeit FLOAT, sauerstoffgehalt FLOAT, ph FLOAT, temperatur FLOAT);
  task :rhein  do
    db = PG::Connection.new(host: 'sqlviz.bbz.cloud', port: 1234, dbname: 'sqlviz_postgres', user: 'postgres', password: pw)
    #db = PG::Connection.new(host: 'localhost', port: 5432, dbname: 'sqlviz_development', user: 'postgres', password: 'postgres')
    rows = CSV.read('/home/anja/Code/BBZ/sqlviz/samples/Rheinmesswerte.csv', headers: true, col_sep: ";")
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

  # Solardaten Schweiz
  # CREATE TABLE data_kanton (id SERIAL PRIMARY KEY, kuerzel TEXT NOT NULL, name TEXT NOT NULL);
  task :kanton  do
    db = PG::Connection.new(host: 'sqlviz.bbz.cloud', port: 1234, dbname: 'sqlviz_postgres', user: 'postgres', password: pw)
    rows = CSV.read('/home/anja/Code/BBZ/sqlviz/samples/kantone.csv', headers: true, col_sep: ",")
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
    # CREATE TABLE data_solar (id SERIAL PRIMARY KEY, gemeinde TEXT NOT NULL, Scenario1_RoofsOnly FLOAT NOT NULL, Scenario2_RoofsOnly FLOAT NOT NULL, Scenario3_RoofsFacades FLOAT NOT NULL, Scenario4_RoofsFacades FLOAT NOT NULL, kanton_id INT REFERENCES data_kanton(id));
  task :solar  do
    db = PG::Connection.new(host: 'sqlviz.bbz.cloud', port: 1234, dbname: 'sqlviz_postgres', user: 'postgres', password: pw)
    #db = PG::Connection.new(host: 'localhost', port: 5432, dbname: 'sqlviz_development', user: 'postgres', password: 'postgres')
    rows = CSV.read('/home/anja/Code/BBZ/sqlviz/samples/Solarenergiepotenziale.csv', headers: true, col_sep: ",")
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

  # Todesfaelle Schweiz 
  # CREATE TABLE data_todesfaelle (id SERIAL PRIMARY KEY, jahr INT NOT NULL, kalenderwoche INT NOT NULL, altersgruppe TEXT NOT NULL, geschlecht TEXT NOT NULL, todesfaelle INT NOT NULL, kanton_id INT REFERENCES data_kanton(id));
  task :todesfaelle  do
    db = PG::Connection.new(host: 'sqlviz.bbz.cloud', port: 1234, dbname: 'sqlviz_postgres', user: 'postgres', password: pw)
    #db = PG::Connection.new(host: 'localhost', port: 5432, dbname: 'sqlviz_development', user: 'postgres', password: 'postgres')
    rows = CSV.read('/home/anja/Code/BBZ/sqlviz/samples/Todesfaelle.csv', headers: true, col_sep: ",")
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

  # Luftqualitaet Zuerich 
  # CREATE TABLE data_luftqualitaet (id SERIAL PRIMARY KEY, datum DATE NOT NULL, standort TEXT NOT NULL, parameter TEXT NOT NULL, einheit TEXT NOT NULL, wert INT);
  task :luftqualitaet  do
    db = PG::Connection.new(host: 'sqlviz.bbz.cloud', port: 1234, dbname: 'sqlviz_postgres', user: 'postgres', password: pw)
    #db = PG::Connection.new(host: 'localhost', port: 5432, dbname: 'sqlviz_development', user: 'postgres', password: 'postgres')
    (1983..2021).each do |year|
      rows = CSV.read("/home/anja/Code/BBZ/sqlviz/samples/ugz_ogd_air_d1_#{year}.csv", headers: true, col_sep: ",")
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
