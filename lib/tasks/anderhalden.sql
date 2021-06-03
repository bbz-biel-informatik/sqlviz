CREATE TABLE data_stock_symbols (
  id SERIAL PRIMARY KEY,
  name TEXT NOT NULL
);

CREATE TABLE data_stock_prices (
  id SERIAL PRIMARY KEY,
  date TIMESTAMP NOT NULL,
  stock_symbol_id INT REFERENCES data_stock_symbols(id) NOT NULL,
  price FLOAT NOT NULL
);
