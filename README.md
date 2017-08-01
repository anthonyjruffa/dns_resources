# DnsResources

Uses the Ruby Resolv class to fetch DNS resource information from a host and return it in a way to easily be used.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'dns_resources'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install dns_resources

## Usage

```ruby
require 'dns_resources'

# The `host` parameter can be an IP address or a hostname.
# The `type` parameter can consist of any of the supported types.

# Return all resources for a host.
DnsResources.get_all_resources(host)

# Return a single resource of the specified type.
DnsResources.get_resource_by_type(host, type)
```

### Supported resource types:
| Ruby Resolv Type                   | String value |
| ---------------------------------- | ------------ |
| `Resolv::DNS::Resource::IN::A`     | `"IPv4"`     |
| `Resolv::DNS::Resource::IN::AAAA`  | `"IPv6"`     |
| `Resolv::DNS::Resource::IN::CNAME` | `"cname"`    |
| `Resolv::DNS::Resource::HINFO`     | `"hinfo"`    |
| `Resolv::DNS::Resource::MINFO`     | `"minfo"`    |
| `Resolv::DNS::Resource::MX`        | `"mx"`       |
| `Resolv::DNS::Resource::NS`        | `"ns"`       |
| `Resolv::DNS::Resource::PTR`       | `"ptr"`      |
| `Resolv::DNS::Resource::SOA`       | `"soa"`      |
| `Resolv::DNS::Resource::IN::SRV`   | `"srv"`      |
| `Resolv::DNS::Resource::TXT`       | `"txt"`      |
| `Resolv::DNS::Resource::IN::WKS`   | `"wks"`      |

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake test` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing
- Fork the project
- Make your changes
- Add tests for your changes
- Submit a pull request

Bug reports and pull requests are welcome on GitHub at https://github.com/anthonyjruffa/dns_resources. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
