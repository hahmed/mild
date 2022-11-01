# Mild

Mild, makes your pull requests easier to manage.

When I was hacking on the GitHub api (octokit.net), I found there was no easy way to find all the pull requests that had 50 changes in total for example. This gem gives you a really easy way to grep small PR's so you could review.

Aside from this I found a couple of other scenarios where I found it would be really cool to pick up an old PR which I have already reviewed, and not got back to in a while.

## Installation

Install Mild as a gem:

    $ gem install mild

## Usage

Here is the API I'm committing to, which is likely to change over time.

First, make sure to export your GitHub token, which you can generate from GitHub on the personal access tokens page.

```shell
$ export MILD_GITHUB_TOKEN=your_personal_access_token
```

#### latest

```shell
$ mild latest rails/rails
```

Get all the latest pull requests for a repo. The output will look something like this;

```
This change fixes to_json serialization
authored_by: datanoise, https://github.com/rails/rails/pull/4
files changed: 1, total changes: 12
```

#### smallest

Get the smallest pull requests, which is calculated by looking at the number of additions and subtractions.

```shell
$ mild smallest rails/rails -c 50
$ mild smallest rails -c 50
```

NOTE: there is a -c flag which is used for count, i.e. the total amount of changes to limit this query. The default amount is set to 25 changes.

#### reviewed

Get all pull requests that have been reviewed by me. You can pass in the -u flag to get all pull requests reviewed by that user instead. Useful for finding all pull requests that have been reviewed but still not merged.

```shell
$ mild reviewed rails/rails -u hahmed
```

All available options

-u user (GitHub login)
-l limit (any number, default: 100)
-s status (open|closed|all, default: open)
-c limit (any number, default: 25)

Not all options are available for every request.

NOTE: Repo names without an owner are auto expanded, so rails becomes rails/rails.

## WIP

Here are a list of things I want to get done before I release this gem.

- Implement reviewed
- Implement smallest
- Paginate (all requests in graphql will only pull first 100 items)
- Cache results locally in a yaml file per repo ~./mild/repo_name.yaml
- tty output

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake test` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/hahmed/mild. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [code of conduct](https://github.com/[USERNAME]/mild/blob/master/CODE_OF_CONDUCT.md).

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the Mild project's codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/[USERNAME]/mild/blob/master/CODE_OF_CONDUCT.md).
