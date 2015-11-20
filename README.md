# SlackBomb

A gem for bombarding channels in slack with messages

## Installation

Add this line to your application's Gemfile:

```bash
git clone git@github.com:davidbegin/slack_bomb.git

cd slack_bomb
```

Update the config/slack_hook.yml to use your actual slack hook.

Update config/defaults to your personal preferences.

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

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/slack_bomb. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](contributor-covenant.org) code of conduct.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

