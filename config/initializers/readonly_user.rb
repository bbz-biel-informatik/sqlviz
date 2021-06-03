database_url = ENV['READONLY_DATABASE_URL']
begin
  URI.parse(database_url)
rescue URI::InvalidURIError
  raise StandardError, 'Please set the READONLY_DATABASE_URL environment variable to a valid PostgreSQL connection string' if database_url.blank?
end
