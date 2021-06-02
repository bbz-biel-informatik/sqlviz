require 'clockwork'
require 'rake'
include Clockwork

every(300, "fetch_stock") do
  `rake anderhalden:import_btc`
  `rake anderhalden:import_eth`
end
