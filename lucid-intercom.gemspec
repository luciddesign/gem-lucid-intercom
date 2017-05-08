$: << "#{__dir__}/lib"

require 'lucid_intercom/version'

Gem::Specification.new do |s|
  s.name = 'lucid-intercom'
  s.version = Lucid::Intercom::VERSION
  s.license = 'ISC'
  s.author = 'Kelsey Judson'
  s.email = 'kelsey@lucid.co.nz'
  s.summary = 'Lucid integration for Intercom'
  s.homepage = 'https://github.com/luciddesign/lucid-intercom'

  s.files = Dir.glob('lib/**/*') + [
    'README.md'
  ]
end
