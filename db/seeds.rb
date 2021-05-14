# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

p = Page.create!(name: 'Testpage')
(1..20).each do |i|
  Page.create!(name: "Testpage #{i}")
end
v1 = Visual.create!(page: p, name: 'Table', type: Visuals::Table)
q1 = Query.create!(visual: v1, query: 'SELECT name, id FROM pages');

v2 = Visual.create!(page: p, name: 'Bar', type: Visuals::Bar)
q2 = Query.create!(visual: v2, query: 'SELECT name, id FROM pages');

v3 = Visual.create!(page: p, name: 'Line', type: Visuals::Line)
q3 = Query.create!(visual: v3, query: 'SELECT name, id, (100 - id) AS antiid FROM pages');
