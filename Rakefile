# frozen_string_literal: true

task default: :run

desc "Run all scenarios (eq to bundle exec quke)"
task :run do
  sh %( bundle exec quke )
end

desc "Runs the tests used by continuous integration to check the project"
task :ci do
  sh %( QUKE_CONFIG=config/ci.config.yml bundle exec quke --tags @ci )
end

desc "Run @smoke tests against the local environment"
task :loc do
  sh %( QUKE_CONFIG=config/loc.config.yml bundle exec quke --tags @smoke)
end

desc "Run @smoke tests against the dev environment"
task :dev do
  sh %( QUKE_CONFIG=config/dev.config.yml bundle exec quke --tags @smoke)
end

desc "Run @smoke tests against the test environment"
task :tst do
  sh %( QUKE_CONFIG=config/tst.config.yml bundle exec quke --tags @smoke)
end

desc "Run @smoke tests against the pre-production environment"
task :pre do
  sh %( QUKE_CONFIG=config/pre.config.yml bundle exec quke --tags @smoke)
end

desc "Run all browserstack tests"
task browserstack: %i[
  chrome63_osx
  chrome63_w7
  chrome64_osx
  edge15_w10
  edge16_w10
  firefox58_osx
  firefox58_w8
  firefox59_osx
  firefox59_w10
  galaxy_note_8
  google_pixel
  ie11_w10
  iphone_7
  iphone_x
  safari9_osx
  safari10_osx
  safari11_osx
]

desc "Run @smoke tests against Chrome 63 OS X"
task :chrome63_osx do
  sh %( QUKE_CONFIG=config/browserstack/chrome63_osx.config.yml bundle exec quke --tags @smoke)
end

desc "Run @smoke tests against Chrome 63 Windows 7"
task :chrome63_w7 do
  sh %( QUKE_CONFIG=config/browserstack/chrome63_w7.config.yml bundle exec quke --tags @smoke)
end

desc "Run @smoke tests against Chrome 64 OS X"
task :chrome64_osx do
  sh %( QUKE_CONFIG=config/browserstack/chrome63_osx.config.yml bundle exec quke --tags @smoke)
end

desc "Run @smoke tests against Edge 15 Windows 10"
task :edge15_w10 do
  sh %( QUKE_CONFIG=config/browserstack/edge15_w10.config.yml bundle exec quke --tags @smoke)
end

desc "Run @smoke tests against Edge 16 Windows 10"
task :edge16_w10 do
  sh %( QUKE_CONFIG=config/browserstack/edge16_w10.config.yml bundle exec quke --tags @smoke)
end

desc "Run @smoke tests against Firefox 58 OS X"
task :firefox58_osx do
  sh %( QUKE_CONFIG=config/browserstack/firefox58_osx.config.yml bundle exec quke --tags @smoke)
end

desc "Run @smoke tests against Firefox 58 Windows 8"
task :firefox58_w8 do
  sh %( QUKE_CONFIG=config/browserstack/firefox58_w8.config.yml bundle exec quke --tags @smoke)
end

desc "Run @smoke tests against Firefox 59 OS X"
task :firefox59_osx do
  sh %( QUKE_CONFIG=config/browserstack/firefox59_osx.config.yml bundle exec quke --tags @smoke)
end

desc "Run @smoke tests against Firefox 59 Windows 10"
task :firefox59_w10 do
  sh %( QUKE_CONFIG=config/browserstack/firefox59_w10.config.yml bundle exec quke --tags @smoke)
end

desc "Run @smoke tests against Samsung Galaxy Note 8"
task :galaxy_note_8 do
  sh %( QUKE_CONFIG=config/browserstack/galaxy_note_8.config.yml bundle exec quke --tags @smoke)
end

desc "Run @smoke tests against Google Pixel 2"
task :google_pixel do
  sh %( QUKE_CONFIG=config/browserstack/google_pixel.config.yml bundle exec quke --tags @smoke)
end

desc "Run @smoke tests against Internet Explorer 11.0 Windows 10"
task :ie11_w10 do
  sh %( QUKE_CONFIG=config/browserstack/ie11_w10.config.yml bundle exec quke --tags @smoke)
end

desc "Run @smoke tests against iPhone 7"
task :iphone_7 do
  sh %( QUKE_CONFIG=config/browserstack/iphone_7.config.yml bundle exec quke --tags @smoke)
end

desc "Run @smoke tests against iPhone X"
task :iphone_x do
  sh %( QUKE_CONFIG=config/browserstack/iphone_x.config.yml bundle exec quke --tags @smoke)
end

desc "Run @smoke tests against Safari 9 OS X"
task :safari12_osx do
  sh %( QUKE_CONFIG=config/browserstack/safari9_osx.config.yml bundle exec quke --tags @smoke)
end

desc "Run @smoke tests against Safari 10 OS X"
task :safari12_osx do
  sh %( QUKE_CONFIG=config/browserstack/safari10_osx.config.yml bundle exec quke --tags @smoke)
end

desc "Run @smoke tests against Safari 11 OS X"
task :safari12_osx do
  sh %( QUKE_CONFIG=config/browserstack/safari11_osx.config.yml bundle exec quke --tags @smoke)
end

desc "Reset the databases in the vagrant environment"
task :reset_vagrant_dbs do
  reset_dbs
end

# rubocop:disable Metrics/LineLength
def reset_dbs
  vagrant_loc = ENV["VAGRANT_KEY_LOCATION"]
  raise ArgumentError, "Environment variable VAGRANT_KEY_LOCATION not set" if vagrant_loc.nil? || vagrant_loc.empty?

  vagrant_key = File.join(vagrant_loc, "private_key")
  # The following line does fully reset the local database but prevents tests from running due to MongoDB errors.
  # Uncomment this, bundle exec rake reset_dbs, then vagrant reload.
  system("ssh -i #{vagrant_key} vagrant@192.168.33.11 'export PATH=\"$HOME/.rbenv/bin:$PATH\" && eval \"$(rbenv init -)\" && cd /vagrant/dbreset && . reset_all_and_seed.sh'")

  current_directory = File.dirname(__FILE__)
  Dir.glob("#{current_directory}/fixtures/*.json").each do |fixture|
    path_to_file = "/vagrant/waste-carriers-acceptance-tests/fixtures/#{File.basename(fixture)}"
    system("ssh -i #{vagrant_key} vagrant@192.168.33.11 'mongoimport --db waste-carriers --collection registrations --file #{path_to_file} --username mongoUser --password password1234'")
  end
  puts "Databases reset"
end
# rubocop:enable Metrics/LineLength
