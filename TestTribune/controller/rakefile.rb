require 'rake'
require 'active_record'
require 'yaml'


task :default => :migrate

desc "Migrate the database through scripts in db/migrate. Target specific version with VERSION=x"
task :migrate => :environment do
  ActiveRecord::Migrator.migrate(File.expand_path('../../db/migrate', __FILE__), ENV["VERSION"] ? ENV["VERSION"].to_i : nil )
end

task :environment do
  ActiveRecord::Base.establish_connection(YAML::load(File.open(File.expand_path('../../db/models/database.yml', __FILE__))))
end