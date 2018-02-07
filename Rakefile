# frozen_string_literal: true

$LOAD_PATH << "#{__dir__}/lib"

require 'lucid_intercom/version'

task(default: :build)
task(:build) { system 'gem build lucid_intercom.gemspec' }
task(install: :build) { system "gem install lucid_intercom-#{LucidIntercom::VERSION}.gem" }
task(:clean) { system 'rm lucid_intercom-*.gem' }
