# SlackBomb

Welcome to your new gem! In this directory, you'll find the files you need to be able to package up your Ruby library into a gem. Put your Ruby code in the file `lib/slack_bomb`. To experiment with that code, run `bin/console` for an interactive prompt.

TODO: Delete this and the text above, and describe your gem

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'slack_bomb'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install slack_bomb

## Usage


```bash
bin/slack_bomb --help
    -c, --channel=CHANNEL            Channel to post in. Example: bot-island, becomes #bot-island
    -d, --dry-run                    Don't post to slack, just print Curl command.
    -s, --sleep=SLEEP                How long to wait inbetween requests.
    -t, --multi-threaded             Call to slack with multiple threads
    -m, --message=MESSAGE            What message to bomb slack with. Defaults to random Faker catch phrase.
    -n, --number=NUMBER              Number of request to be made to slack: Default: 50
    -h, --help                       Here are all the options Slack Bomb takes
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake test` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/slack_bomb. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](contributor-covenant.org) code of conduct.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

