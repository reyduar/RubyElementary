require 'rake'
require 'rspec/core/rake_task'
require 'rspec'
require 'rspec/core'
require 'active_record'
require 'yaml'
 
SPEC_SUITES = [
  { :id => :regression, :title => 'AMEX REGRESSION TEST SUITE', :pattern => "*_spec.rb" }, 
  { :id => :current, :title => 'AMEX HOTEL REGRESSION TEST SUITE - HOTEL', :pattern => "*axpt513_axpt4544_axpt1716_axpt909_axpt910_axpt911*spec.rb" },     
]

task :default => :migrate

desc "Migrate the database through scripts in db/migrate. Target specific version with VERSION=x"
task :migrate => :environment do
  ActiveRecord::Migrator.migrate(File.expand_path('../../db/migrate', __FILE__), ENV["VERSION"] ? ENV["VERSION"].to_i : nil )
end

task :environment do
  ActiveRecord::Base.establish_connection(YAML::load(File.open(File.expand_path('../../db/models/database.yml', __FILE__))))
  #ActiveRecord::Base.logger = Logger.new(File.open('database.log', 'a'))
end

desc 'Load the seed data from db/seeds.rb'
task :seed => :environment do
  seed_file = File.expand_path('../../db/seeds.rb', __FILE__)
  load(seed_file) if File.exist?(seed_file)
end

##############

namespace :spec do
  namespace :suite do
    SPEC_SUITES.each do |suite|
     desc "Run all specs for #{suite[:title]} spec suite"
      RSpec::Core::RakeTask.new(suite[:id]) do |t|
        t.pattern = suite[:pattern]
        t.verbose = false
        t.rspec_opts = ["--color", "--format", "progress", "--format", "documentation", "-o", "logs/documentation_format_report_#{Time.now.strftime('%Y%m%d-%H%M%S')}.txt", "--format", "html", "-o", "logs/rspec_html_format_report_#{Time.now.strftime('%Y%m%d-%H%M%S')}.html"]
      end
    end
    desc "Run all spec suites"
    task :all => :environment do
      SPEC_SUITES.each do |suite|
        logger.info "Running #{suite[:title]} ..."
        Rake::Task["spec:suite:#{suite[:id]}"].execute
      end
    end
  end
end
