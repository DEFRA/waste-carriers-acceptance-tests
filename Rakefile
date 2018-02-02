# frozen_string_literal: true

require "rubocop/rake_task"

RuboCop::RakeTask.new

task default: :run

# Remember to create an environment variable in Travis (can be set to anything)!
if ENV["TRAVIS"]
  # Setting the default is additive. So if we didn't add the following line
  # :default would now run both all tests and rubocop
  Rake::Task[:default].clear
  task default: [:ci]
end

desc "Run all scenarios (eq to bundle exec quke)"
task :run do
  sh %( bundle exec quke )
end

desc "Run browser test"
task browserstack: [:reset] do
  # sh %( QUKE_CONFIG=.config_iPhone_X.yml bundle exec quke --tags @wip)
  sh %( QUKE_CONFIG=.config_iPhone6s.yml bundle exec quke --tags @wip)
end

desc "Run any WIP after resetting the database"
task clean_wip: [:reset] do
  sh %( QUKE_CONFIG=.config.yml bundle exec quke --tags @wip)
end

# rubocop:disable Metrics/LineLength
desc "Reset the database in the vagrant environment"
task :reset do
  vagrant_loc = ENV["VAGRANT_KEY_LOCATION"]
  raise ArgumentError, "Environment variable VAGRANT_KEY_LOCATION not set" if vagrant_loc.nil? || vagrant_loc.empty?

  vagrant_key = File.join(vagrant_loc, "private_key")
  cmd = "ssh -i #{vagrant_key} vagrant@192.168.33.11 'cd /vagrant/waste-carriers-renewals && export PATH=\"$HOME/.rbenv/bin:$PATH\" && eval \"$(rbenv init -)\" && bundle exec rake db:reset'"
  system(cmd)

  puts "Databases reset"
end
# rubocop:enable Metrics/LineLength

desc "Runs the tests used by continuous integration to check the project"
task :ci do
  Rake::Task["rubocop"].invoke
  sh %( QUKE_CONFIG=.config-ci.yml bundle exec quke --tags @ci )
end
