# frozen_string_literal: true

require 'match'

require_relative 'utils'

module Canalizador
  class IosUtils
    def self.upload_certificates_and_profiles(type)
      Canalizador::Utils.validate_environment_variables(
        'IOS_PROFILES_AND_CERTIFICATES_TO_UPLOAD_PATH',
        'IOS_PROFILES_AND_CERTIFICATES_REPO_URL',
        'MATCH_PASSWORD'
      )

      files_to_upload_path = ENV['IOS_PROFILES_AND_CERTIFICATES_TO_UPLOAD_PATH']
      git_url = ENV['IOS_PROFILES_AND_CERTIFICATES_REPO_URL']

      # STORAGE
      storage = Match::Storage.for_mode(
        'git',
        {
          git_url: git_url,
          shallow_clone: false,
          git_branch: 'master',
          clone_branch_directly: false
        }
      )
      storage.download

      # ENCRYPTION
      encryption = Match::Encryption.for_storage_mode(
        'git',
        { git_url: git_url, working_directory: storage.working_directory }
      )
      encryption.decrypt_files

      certifcates_folder = nil
      case type
      when 'development'
        certifcates_folder = 'development'
      when 'adhoc'
        certifcates_folder = 'distribution'
      when 'appstore'
        certifcates_folder = 'distribution'
      end

      # CERTIFICATES
      files_to_upload_dir = Dir["#{files_to_upload_path}/*.{cer,p12}"]
      files_to_upload_dir.each do |filename|
        name = File.basename(filename)
        dest_file = "#{storage.working_directory}/certs/#{certifcates_folder}/#{name}"
        FileUtils.cp(filename, dest_file)
      end

      # PROFILES
      files_to_upload_dir = Dir["#{files_to_upload_path}/*.{mobileprovision,provisionprofile}"]
      files_to_upload_dir.each do |filename|
        name = File.basename(filename)
        dest_file = "#{storage.working_directory}/profiles/#{type}/#{name}"
        FileUtils.cp(filename, dest_file)
      end

      # COMMITING
      encryption.encrypt_files
      files_to_commit = Dir[File.join(storage.working_directory, '**', '*.{cer,p12,mobileprovision,provisionprofile}')]
      storage.save_changes!(files_to_commit: files_to_commit)
    end
  end
end
