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
desc "Run all browserstack tests"
task browserstack: %i[Edge16_W10 Edge15_W10 Firefox58_W8_1 Galaxy_Note_8 Google_Pixel ie11_W10 Chrome63_OSX Chrome63_W7 Chrome64_OSX ie8_W7 iPhone7 iPhone_X Safari11_OSX]
# Firefox59_OSX Firefox59_W10
desc "Run all Safari browser tests"
task safari_browserstack: %i[iPhone7 iPhone_X Safari9_1_OSX Safari10_1_OSX Safari11_OSX]
# rubocop:enable Metrics/LineLength

desc "Run Chrome 64 OS X test"
task :Chrome64_OSX  do
  reset_dbs
  sh %( QUKE_CONFIG=.config_Chrome64_OSX.yml bundle exec quke --tags @dashboard --tags ~@broken)
end

desc "Run Chrome 63 OS X test"
task :Chrome63_OSX  do
  reset_dbs
  sh %( QUKE_CONFIG=.config_Chrome63_OSX.yml bundle exec quke --tags @dashboard --tags ~@broken)
end

desc "Run Chrome 63 Windows 7 test"
task :Chrome63_W7 do
  reset_dbs
  sh %( QUKE_CONFIG=.config_Chrome63_W7.yml bundle exec quke --tags @dashboard --tags ~@broken)
end

desc "Run Edge 16 Windows 10 test"
task :Edge16_W10  do
  reset_dbs
  sh %( QUKE_CONFIG=.config_Edge16_W10.yml bundle exec quke --tags @dashboard --tags ~@broken)
end

desc "Run Edge 15 Windows 10 test"
task :Edge15_W10 do
  reset_dbs
  sh %( QUKE_CONFIG=.config_Edge15_W10.yml bundle exec quke --tags @dashboard --tags ~@broken)
end

desc "Run Internet explorer 11.0 Windows 10 test"
task :ie11_W10 do
  reset_dbs
  sh %( QUKE_CONFIG=.config_ie11_W10.yml bundle exec quke --tags @dashboard --tags ~@broken)
end

desc "Run Safari 11 OS X test"
task :Safari11_OSX  do
  reset_dbs
  sh %( QUKE_CONFIG=.config_Safari11_OSX.yml bundle exec quke --tags @dashboard --tags ~@broken)
end

desc "Run Safari 10.1 OS X test"
task :Safari10_1_OSX  do
  reset_dbs
  sh %( QUKE_CONFIG=.config_Safari10_1_OSX.yml bundle exec quke --tags @dashboard --tags ~@broken)
end

desc "Run Safari 9.1 OS X test"
task :Safari9_1_OSX  do
  reset_dbs
  sh %( QUKE_CONFIG=.config_Safari9_1_OSX.yml bundle exec quke --tags @dashboard --tags ~@broken)
end

desc "Run Firefox 59 OS X test"
task :Firefox59_OSX  do
  reset_dbs
  sh %( QUKE_CONFIG=.config_Firefox59_OSX.yml bundle exec quke --tags @dashboard --tags ~@broken)
end

desc "Run Firefox 58 OS X test"
task :Firefox58_OSX  do
  reset_dbs
  sh %( QUKE_CONFIG=.config_Firefox58_OSX.yml bundle exec quke --tags @dashboard --tags ~@broken)
end

desc "Run Firefox 59 W10 test"
task :Firefox59_W10  do
  reset_dbs
  sh %( QUKE_CONFIG=.config_Firefox59_W10.yml bundle exec quke --tags @dashboard --tags ~@broken)
end

desc "Run Firefox 58 W8.1"
task :Firefox58_W8_1 do
  reset_dbs
  sh %( QUKE_CONFIG=.config_Firefox58_W8_1.yml bundle exec quke --tags @dashboard --tags ~@broken)
end

desc "Run iPhone X test"
task :iPhone_X do
  reset_dbs
  sh %( QUKE_CONFIG=.config_iPhone_X.yml bundle exec quke --tags @dashboard --tags ~@broken)
end

desc "Run iPhone 7 test"
task :iPhone7 do
  reset_dbs
  sh %( QUKE_CONFIG=.config_iPhone7.yml bundle exec quke --tags @dashboard --tags ~@broken)
end

desc "Run Samsung Galaxy Note 8 test"
task :Galaxy_Note_8 do
  reset_dbs
  sh %( QUKE_CONFIG=.config_Galaxy_Note_8.yml bundle exec quke --tags @dashboard --tags ~@broken)
end

desc "Run Google Pixel test"
task :Google_Pixel do
  reset_dbs
  sh %( QUKE_CONFIG=.config_Google_Pixel.yml bundle exec quke --tags @dashboard --tags ~@broken)
end

desc "Run all renewal tests"
task :renewals do
  reset_dbs
  sh %( QUKE_CONFIG=.config.yml bundle exec quke --tags @renewal --tags ~@todo --tags ~@broken --tags ~@email)
end

desc "Run all registration tests"
task :registrations do
  reset_dbs
  sh %( QUKE_CONFIG=.config.yml bundle exec quke --tags ~@renewal --tags ~@todo --tags ~@broken --tags ~@email)
end

task :all_tests do
  reset_dbs
  sh %( QUKE_CONFIG=.config.yml bundle exec quke --tags --tags ~@todo --tags ~@broken --tags ~@email)
end

desc "Runs the tests used by continuous integration to check the project"
task :ci do
  Rake::Task["rubocop"].invoke
  sh %( QUKE_CONFIG=.config-ci.yml bundle exec quke --tags @ci )
end

desc "reset the frontend and renewals database in the vagrant environment"
task :reset_dbs do
  reset_dbs
end

# rubocop:disable Metrics/LineLength

def reset_dbs
  vagrant_loc = ENV["VAGRANT_KEY_LOCATION"]
  raise ArgumentError, "Environment variable VAGRANT_KEY_LOCATION not set" if vagrant_loc.nil? || vagrant_loc.empty?

  vagrant_key = File.join(vagrant_loc, "private_key")
  system("ssh -i #{vagrant_key} vagrant@192.168.33.11 'export PATH=\"$HOME/.rbenv/bin:$PATH\" && eval \"$(rbenv init -)\" && cd /vagrant/dbreset && . reset_all_and_seed.sh'")

  current_directory = File.dirname(__FILE__)
  Dir.glob("#{current_directory}/fixtures/*.json").each do |fixture|
    path_to_file = "/vagrant/waste-carriers-acceptance-tests/fixtures/#{File.basename(fixture)}"
    system("ssh -i #{vagrant_key} vagrant@192.168.33.11 'mongoimport --db waste-carriers --collection registrations --file #{path_to_file} --username mongoUser --password password1234'")
  end
  puts "Databases reset"
end
# rubocop:enable Metrics/LineLength
