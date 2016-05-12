namespace :swagger do
  desc "Updates API documentation json."
  task :regenerate => :environment do
    Apidocs.run
    puts "Success."
  end
end