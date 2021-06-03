require 'rubyXL'
require 'rubyXL/convenience_methods'

desc "Load data from a CSV file into the database"
namespace :users do
  task :import  do
    workbook = RubyXL::Parser.parse(Rails.root.join("lib", "tasks", "liste.xlsx"))
    worksheet = workbook.worksheets[0]

    worksheet.each do |row|
      fname = row[0].value
      lname = row[1].value
      username = row[2].value
      email = row[3].value
      pw = row[4].value

      puts "User.create(email: '#{email}', password: '#{pw}')"
    end
  end
end
