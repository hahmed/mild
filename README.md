# Mild

Mild, a GraphQL client example app using the GitHub api.

## Installation

Install Mild as a gem:

    $ gem install mild

## Usage

First, make sure to export your GitHub token, which you can generate from GitHub on the personal access tokens page.

```shell
$ export MILD_GITHUB_TOKEN=your_personal_access_token
```

#### mentioned

```shell
$ mild latest rails/rails
```

NOTE: Repo names without an owner are auto expanded, so rails becomes rails/rails.

Get all pull requests where I have been mentioned. The output will look something like this;

```
This change fixes to_json serialization
authored_by: datanoise, https://github.com/rails/rails/pull/4
files changed: 1, total changes: 12
```

#### reviewed

```shell
$ mild reviewed rails/rails
```

Get all open pull requests that have been reviewed by me.

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake test` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/hahmed/mild. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [code of conduct](https://github.com/[USERNAME]/mild/blob/master/CODE_OF_CONDUCT.md).

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the Mild project's codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/[USERNAME]/mild/blob/master/CODE_OF_CONDUCT.md).
