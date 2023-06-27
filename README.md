# Canalizador

Canalizador is a ruby gem that provide a collection of utils for mobile apps pipelines.

The collection includes Jira and iOS utils.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'canalizador'
```

And then execute:

    $ bundle

Or install it yourself as:

```bash
$ gem install canalizador
```

## Usage

```ruby
require 'canalizador'

Canalizador.generate_release_notes('main', '1.49.2')

Canalizador.upload_certificates_and_profiles('adhoc')

Canalizador.fetch_certificates_and_profiles('com.domain.app')
```

```bash
JIRA_URL="https://XXXX.atlassian.net" JIRA_PROJECT_SLUG="YYYY" JIRA_USERNAME="ZZZZZ" JIRA_PASSWORD="WWWWWWW" canalizador generate_release_notes develop

IOS_PROFILES_AND_CERTIFICATES_TO_UPLOAD_PATH="~/path/to/profile/directory" IOS_PROFILES_AND_CERTIFICATES_REPO_URL="git@certificates-and-profiles-repo.git" MATCH_PASSWORD="YYYYYY" canalizador upload_certificates_and_profiles adhoc

IOS_PROFILES_AND_CERTIFICATES_REPO_URL="git@certificates-and-profiles-repo.git" MATCH_PASSWORD="YYYYYY" canalizador fetch_certificates_and_profiles com.domain.app,com.domain.app.preview
```

### Jira

#### Generate Release Notes

This method calls the Jira API to generate release notes based on the issues that were included in that specific release.

#### Required environment variables
| Name                | Type     | Description                                                  |
| ------------------- | -------- | ------------------------------------------------------------ |
| `JIRA_URL`          | `string` | URL of the Jira project (e.g. https://XXXX.atlassian.net)    |
| `JIRA_PROJECT_SLUG` | `string` | Slug of the Jira project                                     |
| `JIRA_USERNAME`     | `string` | Username of the Jira user to be used for the API calls       |
| `JIRA_PASSWORD`     | `string` | Token/password of the Jira user to be used for the API calls |

#### Parameters
| Name      | Type     | Description                                                                   |
| --------- | -------- | ----------------------------------------------------------------------------- |
| `branch`  | `string` | Target branch of the release (e.g. develop)                                   |
| `version` | `string` | Version code of the release (e.g. 1.49.2) - Optional if `branch` is `develop` |

```ruby
require 'canalizador'

Canalizador.generate_release_notes('main', '1.49.2')
Canalizador.generate_release_notes('develop')
```

```bash
JIRA_URL="https://XXXX.atlassian.net" JIRA_PROJECT_SLUG="YYYY" JIRA_USERNAME="ZZZZZ" JIRA_PASSWORD="WWWWWWW" canalizador generate_release_notes develop

JIRA_URL="https://XXXX.atlassian.net" JIRA_PROJECT_SLUG="YYYY" JIRA_USERNAME="ZZZZZ" JIRA_PASSWORD="WWWWWWW" canalizador generate_release_notes main 1.49.2
```

### iOS

#### Upload Certificates and Profiles

This method uploads the certificates and profiles to a Fastlane-managed repository.

#### Required environment variables
| Name                                           | Type     | Description                                                                                                                     |
| ---------------------------------------------- | -------- | ------------------------------------------------------------------------------------------------------------------------------- |
| `IOS_PROFILES_AND_CERTIFICATES_TO_UPLOAD_PATH` | `string` | Path of the directory where the certificates and/or provisioning profiles to be uploaded are (e.g. ~/path/to/profile/directory) |
| `IOS_PROFILES_AND_CERTIFICATES_REPO_URL`       | `string` | Git SSH path of the repository that stores the certificates and profiles                                                        |
| `MATCH_PASSWORD`                               | `string` | Password to be used to encrypt and decrypt the files                                                                            |

#### Parameters
| Name   | Type     | Description                                                       |
| ------ | -------- | ----------------------------------------------------------------- |
| `type` | `string` | Type of the files to be uploaded (development, adhoc or appstore) |

```ruby
require 'canalizador'

Canalizador.upload_certificates_and_profiles('adhoc')
```

```bash
JIRA_URL="https://XXXX.atlassian.net" JIRA_PROJECT_SLUG="YYYY" JIRA_USERNAME="ZZZZZ" JIRA_PASSWORD="WWWWWWW" canalizador upload_certificates_and_profiles adhoc
```

#### Fetch Certificates and Profiles

This method fetches the certificates and profiles from a Fastlane-managed repository.

#### Required environment variables
| Name                                     | Type     | Description                                                              |
| ---------------------------------------- | -------- | ------------------------------------------------------------------------ |
| `IOS_PROFILES_AND_CERTIFICATES_REPO_URL` | `string` | Git SSH path of the repository that stores the certificates and profiles |
| `MATCH_PASSWORD`                         | `string` | Password to be used to decrypt the files                                 |

#### Parameters
| Name             | Type     | Description                                                                                                                          |
| ---------------- | -------- | ------------------------------------------------------------------------------------------------------------------------------------ |
| `app_bundle_ids` | `string` | List of bundle ids of the certificates and profiles to be fetched, separated by commas  (e.g. com.domain.app,com.domain.app.preview) |

```ruby
require 'canalizador'

Canalizador.fetch_certificates_and_profiles('com.domain.app,com.domain.app.preview')
```

```bash
JIRA_URL="https://XXXX.atlassian.net" JIRA_PROJECT_SLUG="YYYY" JIRA_USERNAME="ZZZZZ" JIRA_PASSWORD="WWWWWWW" canalizador fetch_certificates_and_profiles com.domain.app,com.domain.app.preview
```

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/Gaspard-Bruno/canalizador.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
