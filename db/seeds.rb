# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

u = User.create!(email: 'lukas.diener@bbz-cfp.ch', password: 'asdfasdf')

p = u.pages.create!(name: 'Testpage')
(1..20).each do |i|
  u.pages.create!(name: "Testpage #{i}")
end
v1 = p.visuals.create!(name: 'Table', type: Visuals::Table)
q1 = v1.queries.create!(query: 'SELECT name, id FROM pages');

v2 = p.visuals.create!(name: 'Bar', type: Visuals::Bar)
q2 = v2.queries.create!(query: 'SELECT name, id FROM pages');

v3 = p.visuals.create!(name: 'Line', type: Visuals::Line)
q3 = v3.queries.create!(query: 'SELECT name, id, (100 - id) AS antiid FROM pages');
