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

# rubocop:disable Metrics/LineLength
desc "Run all browser tests"
task browserstack: %i[Chrome63_OSX Chrome63_W7 Chrome64_OSX Edge16_W10 Edge15_W10 Firefox59_OSX Firefox59_W10 Firefox58_W8_1 Galaxy_Note_8 HTC_One_M8 Safari11_OSX Safari10_1_OSX Safari9_1_OSX iPhone_X iPhone7]
# rubocop:enable Metrics/LineLength

desc "Run Chrome 64 OS X test"
task :Chrome64_OSX  do
  reset
  sh %( QUKE_CONFIG=.config_Chrome64_OSX.yml bundle exec quke --tags @wip)
end

desc "Run Chrome 63 OS X test"
task :Chrome63_OSX  do
  reset
  sh %( QUKE_CONFIG=.config_Chrome63_OSX.yml bundle exec quke --tags @wip)
end

desc "Run Chrome 63 Windows 7 test"
task :Chrome63_W7 do
  reset
  sh %( QUKE_CONFIG=.config_Chrome63_W7.yml bundle exec quke --tags @wip)
end

desc "Run Edge 16 Windows 10 test"
task :Edge16_W10  do
  reset
  sh %( QUKE_CONFIG=.config_Edge16_W10.yml bundle exec quke --tags @wip)
end

desc "Run Edge 15 Windows 10 test"
task :Edge15_W10  do
  reset
  sh %( QUKE_CONFIG=.config_Edge15_W10.yml bundle exec quke --tags @wip)
end

desc "Run Safari 11 OS X test"
task :Safari11_OSX  do
  reset
  sh %( QUKE_CONFIG=.config_Safari11_OSX.yml bundle exec quke --tags @wip)
end

desc "Run Safari 10.1 OS X test"
task :Safari10_1_OSX  do
  reset
  sh %( QUKE_CONFIG=.config_Safari10_1_OSX.yml bundle exec quke --tags @wip)
end

desc "Run Safari 9.1 OS X test"
task :Safari9_1_OSX  do
  reset
  sh %( QUKE_CONFIG=.config_Safari9_1_OSX.yml bundle exec quke --tags @wip)
end

desc "Run Firefox 59 OS X test"
task :Firefox59_OSX  do
  reset
  sh %( QUKE_CONFIG=.config_Firefox59_OSX.yml bundle exec quke --tags @wip)
end

desc "Run Firefox 58 OS X test"
task :Firefox58_OSX  do
  reset
  sh %( QUKE_CONFIG=.config_Firefox58_OSX.yml bundle exec quke --tags @wip)
end

desc "Run Firefox 59 W10 test"
task :Firefox59_W10  do
  reset
  sh %( QUKE_CONFIG=.config_Firefox59_W10.yml bundle exec quke --tags @wip)
end

desc "Run Firefox 58 W8.1"
task :Firefox58_W8_1 do
  reset
  sh %( QUKE_CONFIG=.config_Firefox58_W8_1.yml bundle exec quke --tags @wip)
end

desc "Run iPhone X test"
task :iPhone_X do
  reset
  sh %( QUKE_CONFIG=.config_iPhone_X.yml bundle exec quke --tags @wip)
end

desc "Run iPhone 7 test"
task :iPhone7 do
  reset
  sh %( QUKE_CONFIG=.config_iPhone7.yml bundle exec quke --tags @wip)
end

desc "Run Samsung Galaxy Note 8 test"
task :Galaxy_Note_8 do
  reset
  sh %( QUKE_CONFIG=.config_Galaxy_Note_8.yml bundle exec quke --tags @wip)
end

desc "Run HTC One M8 test"
task :HTC_One_M8  do
  reset
  sh %( QUKE_CONFIG=.config_HTC_One_M8.yml bundle exec quke --tags @wip)
end

desc "Run any WIP after resetting the database"
task :clean_wip do
  reset
  sh %( QUKE_CONFIG=.config.yml bundle exec quke --tags @wip)
end

desc "Runs the tests used by continuous integration to check the project"
task :ci do
  Rake::Task["rubocop"].invoke
  sh %( QUKE_CONFIG=.config-ci.yml bundle exec quke --tags @ci )
end

desc "Reset the database in the vagrant environment"
task :reset_db do
  reset
end

# rubocop:disable Metrics/LineLength
def reset
  vagrant_loc = ENV["VAGRANT_KEY_LOCATION"]
  raise ArgumentError, "Environment variable VAGRANT_KEY_LOCATION not set" if vagrant_loc.nil? || vagrant_loc.empty?

  vagrant_key = File.join(vagrant_loc, "private_key")
  cmd = "ssh -i #{vagrant_key} vagrant@192.168.33.11 'cd /vagrant/waste-carriers-renewals && export PATH=\"$HOME/.rbenv/bin:$PATH\" && eval \"$(rbenv init -)\" && bundle exec rake db:reset'"
  system(cmd)

  puts "Databases reset"
end
# rubocop:enable Metrics/LineLength
