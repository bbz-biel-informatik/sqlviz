# 📊 SQL Viz 📈

Application to turn this | into this
:-------------------------:|:-------------------------:
![user interface containing an editable database query](doc/backend.png) | ![chart dynamically generated from above database query](doc/frontend.png)

SQLViz allows users to create custom visualizations for data contained in a database. They don't have to write any glue code but instead can focus on writing SQL queries and a bit of CSS for styling.

## Requirements

This is a normal Rails application, ready to run on Ruby 3. To install, run the following commands:

* Install gems: `bundle install`
* Create DB: `rails db:create`
* Migrate DB: `rails db:migrate`

SQLViz is meant to load data from the same database the application is running in, but can be configured to use a different datasource.

To create a `readonly` user who is allowed to list tables, but can only read
the `data_*`-tables and has no write access, run the following commands:

* `CREATE USER readonly WITH PASSWORD 'mypassword'` to create a user
* `REVOKE ALL ON schema public FROM public` to disable table creation
* `GRANT SELECT ON TABLE data_todesfaelle TO readonly` (repeat for every table) to allow reading
* `GRANT USAGE ON schema public TO readonly` to allow listing of relations

To tell the application about the readonly user, add the PostgreSQL connection string as an environment variable named `READONLY_DATABASE_URL`:

```bash
READONLY_DATABASE_URL=postgres://username:password@host:5432/dbname
```

<hr>
⚠ The credentials of the readonly user will be exposed to the application users! ⚠
<hr>

## Prepared data

The repository contains some prepared datasets ranging from temperature over
air quality to football results. To load these examples, you might require some
additional configuration. The datasets are outlined below:

| Description | Preparation | Notes | Required Config |
|---|---|---|---|
| Live Crypto Data | `rake anderhalden:prepare` | Run `rake anderhalden:import_btc` or `:import_eth` to run once. Enable the clock process `dokku ps:scale clock=1` to run every 5 minutes. | `DATABASE_URL`, `FINNHUB_API_TOKEN` |
| Historic football results | `rake crupi:prepare` | Run `rake crupi:import_games` to import data from fvbj-afbj.ch. This takes a long time. | `DATABASE_URL` |
| Zollikofen Temp and Precipitation | `rake csv:prepare` | Run `rake csv:bern_zollikofen` to import | `DATABASE_URL` |
| Rhein temperature and water quality | `rake csv:prepare` | Run `rake csv:rhein` to import | `DATABASE_URL` |
| Aare temperature and water quality | `rake csv:prepare` | Run `rake csv:aare` to import | `DATABASE_URL` |
| Canton names | `rake csv:prepare` | Run `rake csv:kanton` to import | `DATABASE_URL` |
| Solar potential | `rake csv:prepare` | Run `rake csv:solar` to import | `DATABASE_URL` |
| Deaths by canton and total | `rake csv:prepare` | Run `rake csv:todesfaelle` to import | `DATABASE_URL` |
| Air quality in Zurich | `rake csv:prepare` | Run `rake csv:luftqualitaet` to import | `DATABASE_URL` |

### Additional config

* `DATABASE_URL`: PostgreSQL connection string to connect to the database. Must be permitted to write data
* `FINNHUB_API_TOKEN`: API token for finnhub.io, can be created for free on the website.

### Load data from CSV files

Run `rake csv:load` to load data from a CSV file into the database.

This command only prints the queries it would execute. To actually run the
queries, prepend `WRITE=1`.
