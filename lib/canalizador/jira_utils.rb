# frozen_string_literal: true

require 'net/http'
require 'json'
require 'base64'

require_relative 'utils'

module Canalizador
  class JiraUtils
    def self.fetch_jira_issues(branch, version)
      Canalizador::Utils.validate_environment_variables(
        'JIRA_URL',
        'JIRA_PROJECT_SLUG',
        'JIRA_USERNAME',
        'JIRA_PASSWORD'
      )

      url = if branch == 'develop'
              URI.parse("#{ENV['JIRA_URL']}/rest/api/3/search?jql=project=#{ENV['JIRA_PROJECT_SLUG']} AND status='Ready for Feature Testing'&fields=issuetype,summary")
            else
              URI.parse("#{ENV['JIRA_URL']}/rest/api/3/search?jql=project=#{ENV['JIRA_PROJECT_SLUG']} AND fixVersion='#{version}'&fields=issuetype,summary")
            end

      request = Net::HTTP::Get.new(url.request_uri)
      request.basic_auth(ENV['JIRA_USERNAME'], ENV['JIRA_PASSWORD'])

      response = Net::HTTP.start(url.host, url.port, use_ssl: true) do |http|
        http.request(request)
      end

      if response.code == '200'
        json_response = JSON.parse(response.body)

        issues = json_response['issues']

        issues.map do |issue|
          issue_code = issue['key']
          issue_type = issue['fields']['issuetype']['name']
          issue_name = issue['fields']['summary']

          "- [#{issue_type}]#{issue_code} - #{issue_name}"
        end
      else
        puts "Request failed with HTTP status code #{response.code}"
        []
      end
    end

    def self.generate_release_notes(branch, version)
      issues = fetch_jira_issues(branch, version)

      if issues.empty?
        'No issues found'
      else
        "Version #{version} Issues:\n" + issues.join("\n")
      end
    end
  end
end
