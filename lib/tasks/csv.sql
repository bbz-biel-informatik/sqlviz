CREATE TABLE data_bern_zollikofen (
  id SERIAL PRIMARY KEY,
  jahr INT NOT NULL,
  monat INT NOT NULL,
  temperatur FLOAT NOT NULL,
  niederschlag FLOAT NOT NULL
);

CREATE TABLE data_rhein (
  id SERIAL PRIMARY KEY,
  start TIMESTAMP NOT NULL,
  ende TIMESTAMP NOT NULL,
  elektrische_leitfaehigkeit FLOAT,
  sauerstoffgehalt FLOAT,
  ph FLOAT, temperatur FLOAT
);

CREATE TABLE data_aare (
  id SERIAL PRIMARY KEY,
  datum TIMESTAMP NOT NULL,
  abfluss FLOAT, pegel FLOAT,
  sauerstoffgehalt FLOAT,
  temperatur FLOAT
);

CREATE TABLE data_kanton (
  id SERIAL PRIMARY KEY,
  kuerzel TEXT NOT NULL,
  name TEXT NOT NULL
);

CREATE TABLE data_solar (
  id SERIAL PRIMARY KEY,
  gemeinde TEXT NOT NULL,
  Scenario1_RoofsOnly FLOAT NOT NULL,
  Scenario2_RoofsOnly FLOAT NOT NULL,
  Scenario3_RoofsFacades FLOAT NOT NULL,
  Scenario4_RoofsFacades FLOAT NOT NULL,
  kanton_id INT REFERENCES data_kanton(id)
);

CREATE TABLE data_todesfaelle (
  id SERIAL PRIMARY KEY,
  jahr INT NOT NULL,
  kalenderwoche INT NOT NULL,
  altersgruppe TEXT NOT NULL,
  geschlecht TEXT NOT NULL,
  todesfaelle INT NOT NULL,
  kanton_id INT REFERENCES data_kanton(id)
);

CREATE TABLE data_geburten (
  id SERIAL PRIMARY KEY,
  jahr INT NOT NULL,
  geburten INT NOT NULL,
  kanton_id INT REFERENCES data_kanton(id)
);

CREATE TABLE data_luftqualitaet (
  id SERIAL PRIMARY KEY,
  datum TIMESTAMP NOT NULL,
  standort TEXT NOT NULL,
  parameter TEXT NOT NULL,
  einheit TEXT NOT NULL,
  wert INT
);
