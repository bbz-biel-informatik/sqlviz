# SQL Viz

## Load data from CSV files

Run `rake csv:load` to load data from a CSV file into the database.

This command only prints the queries it would execute. To actually run the
queries, prepend `WRITE=1`.

## DB Setup

To create a `readonly` user who is allowed to list tables, but can only read
the `data_*`-tables and has no write access, run the following commands:

* `CREATE USER readonly WITH PASSWORD 'mypassword'` to create a user
* `REVOKE ALL ON schema public FROM public` to disable table creation
* `GRANT SELECT ON TABLE data_todesfaelle TO readonly` (repeat for every table) to allow reading
* `GRANT USAGE ON schema public TO readonly` to allow listing of relations
