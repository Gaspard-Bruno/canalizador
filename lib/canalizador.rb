# frozen_string_literal: true

require 'dotenv'
Dotenv.load

require_relative 'canalizador/version'
require_relative 'canalizador/jira_utils'
require_relative 'canalizador/ios_utils'

module Canalizador
  def self.generate_release_notes(branch, version)
    JiraUtils.generate_release_notes(branch, version)
  end

  def self.upload_certificates_and_profiles(type)
    IosUtils.upload_certificates_and_profiles(type)
  end

  def self.fetch_certificates_and_profiles(app_bundle_ids)
    IosUtils.fetch_certificates_and_profiles(app_bundle_ids)
  end
end
