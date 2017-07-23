$:.unshift "#{__dir__}/lib"

require 'lucid/intercom/version'

Gem::Specification.new do |s|
  s.add_development_dependency 'rspec', '~> 3.6.0'
  s.add_runtime_dependency 'dry-struct', '~> 0.3.0'
  s.add_runtime_dependency 'dry-types', '~> 0.11.0'
  s.author = 'Kelsey Judson'
  s.email = 'kelsey@lucid.co.nz'
  s.files = Dir.glob('lib/**/*') + %w(README.md)
  s.homepage = 'https://github.com/lucidnz/gem-lucid-intercom'
  s.license = 'ISC'
  s.name = 'lucid-intercom'
  s.summary = 'Lucid integration for Intercom'
  s.version = Lucid::Intercom::VERSION
end
