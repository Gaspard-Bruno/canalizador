# frozen_string_literal: true

require_relative 'lib/canalizador/version'

Gem::Specification.new do |spec|
  spec.name = 'canalizador'
  spec.version = Canalizador::VERSION
  spec.authors = ['Gaspard+Bruno']
  spec.email = ['hello@gaspardbruno.com']

  spec.summary = 'Collection of utils for mobile apps pipelines.'
  spec.description = 'Collection of utils for mobile apps pipelines that include Jira and iOS utils.'
  spec.homepage = 'https://github.com/Gaspard-Bruno/canalizador'
  spec.license = 'MIT'
  spec.required_ruby_version = '>= 2.6.0'

  spec.metadata['homepage_uri'] = spec.homepage
  spec.metadata['source_code_uri'] = 'https://github.com/Gaspard-Bruno/canalizador'

  spec.files = Dir.glob('{lib,bin}/**/*')
  spec.require_path = 'lib'
  spec.executables = ['canalizador']

  spec.add_dependency('dotenv', '~> 2.7.6')
  spec.add_dependency('fastlane', '~> 2.200.0')
  spec.add_dependency('httparty', '~> 0.20.0')
end
