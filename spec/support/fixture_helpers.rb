# frozen_string_literal: true

require 'yaml'

module RSpec
  module FixtureHelpers
    def self.cache
      @cache ||= Hash.new do |h, path|
        data = File.read("#{__dir__}/../fixtures/#{path}")

        h[path] = path.split('.')[1..-1].reverse.reduce(data) do |data, ext|
          case ext
          when 'erb' then ERB.new(data).result
          when 'yml' then YAML.load(data)
          else
            data
          end
        end
      end
    end

    #
    # @param path [String] relative to /spec/fixtures
    #
    # @return [String, Hash] {Hash} if *.yml
    #
    def fixture(path)
      FixtureHelpers.cache[path]
    end
  end

  configure { |config| config.include FixtureHelpers }
end
