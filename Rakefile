$: << "#{__dir__}/lib"

require 'lucid/intercom/version'

task default: :build

task :build do
  system 'gem build lucid-intercom.gemspec'
end

task install: :build do
  system "gem install lucid-intercom-#{Lucid::Intercom::VERSION}.gem"
end

task :clean do
  system 'rm lucid-intercom-*.gem'
end
