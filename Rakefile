$: << "#{__dir__}/lib"

require 'lucid_intercom/version'

task default: :build

task :build do
  system 'gem build lucid_intercom.gemspec'
end

task install: :build do
  system "gem install lucid_intercom-#{LucidIntercom::VERSION}.gem"
end

task :clean do
  system 'rm lucid_intercom-*.gem'
end
