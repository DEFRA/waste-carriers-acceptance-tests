# frozen_string_literal: true

task default: :run

desc "Run all scenarios (eq to bundle exec quke)"
task :run do
  sh %( bundle exec quke )
end

desc "Run all tests on local"
task :loc do
  sh %( QUKE_CONFIG=config/loc.config.yml bundle exec quke)
end

desc "Run all tests on dev"
task :dev do
  sh %( QUKE_CONFIG=config/dev.config.yml bundle exec quke)
end

desc "Run all tests on test"
task :tst do
  sh %( QUKE_CONFIG=config/tst.config.yml bundle exec quke)
end

desc "Run all tests on pre-production"
task :pre do
  sh %( QUKE_CONFIG=config/pre.config.yml bundle exec quke")
end

desc "Run all tests on local excluding todo, broken, and email"
task :all_tests do
  reset_dbs
  sh %( QUKE_CONFIG=config/loc.config.yml bundle exec quke --tags ~@todo --tags ~@broken --tags ~@email)
end

desc "Run all browserstack tests"
task browserstack: %i[
  chrome63_osx
  chrome63_w7
  chrome64_osx
  edge15_w10
  edge16_w10
  firefox58_osx
  firefox58_w8_1
  firefox59_osx
  firefox59_w10
  galaxy_note_8
  google_pixel
  ie11_w10
  iphone7
  iphone_x
  safari9_1_osx
  safari10_1_osx
  safari11_osx
]

desc "Run all Safari browser tests"
task safari_browserstack: %i[
  iphone7
  iphone_x
  safari9_1_osx
  safari10_1_osx
  safari11_osx
]

desc "Run Chrome 63 OS X test"
task :chrome63_osx  do
  reset_dbs
  sh %( QUKE_CONFIG=config/browserstack/Chrome63_OSX.config.yml bundle exec quke --tags @dashboard --tags ~@broken)
end

desc "Run Chrome 63 Windows 7 test"
task :chrome63_w7 do
  reset_dbs
  sh %( QUKE_CONFIG=config/browserstack/Chrome63_W7.config.yml bundle exec quke --tags @dashboard --tags ~@broken)
end

desc "Run Chrome 64 OS X test"
task :chrome64_osx  do
  reset_dbs
  sh %( QUKE_CONFIG=config/browserstack/Chrome64_OSX.config.yml bundle exec quke --tags @dashboard --tags ~@broken)
end

desc "Run Edge 15 Windows 10 test"
task :edge15_w10 do
  reset_dbs
  sh %( QUKE_CONFIG=config/browserstack/Edge15_W10.config.yml bundle exec quke --tags @dashboard --tags ~@broken)
end

desc "Run Edge 16 Windows 10 test"
task :edge16_w10  do
  reset_dbs
  sh %( QUKE_CONFIG=config/browserstack/Edge16_W10.config.yml bundle exec quke --tags @dashboard --tags ~@broken)
end

desc "Run Firefox 58 OS X test"
task :firefox58_osx  do
  reset_dbs
  sh %( QUKE_CONFIG=config/browserstack/Firefox58_OSX.config.yml bundle exec quke --tags @dashboard --tags ~@broken)
end

desc "Run Firefox 58 W8.1"
task :firefox58_w8_1 do
  reset_dbs
  sh %( QUKE_CONFIG=config/browserstack/Firefox58_W8_1.config.yml bundle exec quke --tags @dashboard --tags ~@broken)
end

desc "Run Firefox 59 OS X test"
task :firefox59_osx  do
  reset_dbs
  sh %( QUKE_CONFIG=config/browserstack/Firefox59_OSX.config.yml bundle exec quke --tags @dashboard --tags ~@broken)
end

desc "Run Firefox 59 W10 test"
task :firefox59_w10  do
  reset_dbs
  sh %( QUKE_CONFIG=config/browserstack/Firefox59_W10.config.yml bundle exec quke --tags @dashboard --tags ~@broken)
end

desc "Run Samsung Galaxy Note 8 test"
task :galaxy_note_8 do
  reset_dbs
  sh %( QUKE_CONFIG=config/browserstack/Galaxy_Note_8.config.yml bundle exec quke --tags @dashboard --tags ~@broken)
end

desc "Run Google Pixel test"
task :google_pixel do
  reset_dbs
  sh %( QUKE_CONFIG=config/browserstack/Google_Pixel.config.yml bundle exec quke --tags @dashboard --tags ~@broken)
end

desc "Run Internet explorer 11.0 Windows 10 test"
task :ie11_w10 do
  reset_dbs
  sh %( QUKE_CONFIG=config/browserstack/ie11_W10.config.yml bundle exec quke --tags @dashboard --tags ~@broken)
end

desc "Run iPhone 7 test"
task :iphone7 do
  reset_dbs
  sh %( QUKE_CONFIG=config/browserstack/iPhone7.config.yml bundle exec quke --tags @dashboard --tags ~@broken)
end

desc "Run iPhone X test"
task :iphone_x do
  reset_dbs
  sh %( QUKE_CONFIG=config/browserstack/iPhone_X.config.yml bundle exec quke --tags @dashboard --tags ~@broken)
end

desc "Run Safari 9.1 OS X test"
task :safari9_1_osx  do
  reset_dbs
  sh %( QUKE_CONFIG=config/browserstack/Safari9_1_OSX.config.yml bundle exec quke --tags @dashboard --tags ~@broken)
end

desc "Run Safari 10.1 OS X test"
task :safari10_1_osx  do
  reset_dbs
  sh %( QUKE_CONFIG=config/browserstack/Safari10_1_OSX.config.yml bundle exec quke --tags @dashboard --tags ~@broken)
end

desc "Run Safari 11 OS X test"
task :safari11_osx  do
  reset_dbs
  sh %( QUKE_CONFIG=config/browserstack/Safari11_OSX.config.yml bundle exec quke --tags @dashboard --tags ~@broken)
end

desc "Runs the tests used by continuous integration to check the project"
task :ci do
  sh %( QUKE_CONFIG=config/ci.config.yml bundle exec quke --tags @ci )
end

desc "reset the frontend and renewals database in the vagrant environment"
task :reset_dbs do
  reset_dbs
end

# rubocop:disable Layout/LineLength
def reset_dbs
  vagrant_loc = ENV["VAGRANT_KEY_LOCATION"]
  raise ArgumentError, "Environment variable VAGRANT_KEY_LOCATION not set" if vagrant_loc.nil? || vagrant_loc.empty?

  vagrant_key = File.join(vagrant_loc, "private_key")
  # The following line fully resets the local database and resets the environment without a full vagrant reload:
  system("ssh -i #{vagrant_key} vagrant@192.168.33.11 'export PATH=\"$HOME/.rbenv/bin:$PATH\" && eval \"$(rbenv init -)\" && source /etc/profile.d/myvars.sh && source /vagrant/dbreset/reset_environment.sh'")

  current_directory = File.dirname(__FILE__)
  Dir.glob("#{current_directory}/fixtures/*.json").each do |fixture|
    path_to_file = "/vagrant/waste-carriers-acceptance-tests/fixtures/#{File.basename(fixture)}"
    system("ssh -i #{vagrant_key} vagrant@192.168.33.11 'mongoimport --db waste-carriers --collection registrations --file #{path_to_file} --username mongoUser --password password1234'")
  end
  puts "Databases reset"
end
# rubocop:enable Layout/LineLength
