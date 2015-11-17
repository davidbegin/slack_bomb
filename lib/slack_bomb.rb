require "slack_bomb/version"
require 'optparse'
require 'yaml'
require 'faker'

module SlackBomb
  API_BUFFER = 0.02
  EMOJIS = YAML.load_file("config/emojis.yml").fetch("emojis").map(&:to_sym)

  class << self
    def bomb!
      @options = parse_options
      if multithreaded?
        threads = (1..5).to_a.map do
          EMOJIS.shuffle.map do |key|
            Thread.new { SlackBomb.post_to_slack(key) }
          end
        end.flatten
        threads.each(&:join)
      else
        (1..5).to_a.map do
          EMOJIS.shuffle.map do |key|
            SlackBomb.post_to_slack(key)
          end
        end
      end
    end

    def post_to_slack(key)
      system full_curl(key)
      sleep API_BUFFER
    end

    private

    def parse_options
      options = {}
      OptionParser.new do |opts|
        opts.on("-c", "--channel", "Channel to post in. Example: #bot-island") do |c|
          options[:channel] = c
        end
        opts.on_tail("-h", "--help", "Here are all the options Slack Bomb takes") do
          puts opts
          exit
        end
      end.parse!
      options
    end

    def channel
      @options[:channel] || "#bot-island"
    end

    def name
      Faker::Name.name
    end

    def full_curl(key)
      <<-CURL
        #{curl_cmd}\
        'payload={\
          "channel": "#{channel}",\
          "username": "#{name}",\
          "text": "#{Faker::Company.catch_phrase} is the right solution!",\
          "icon_emoji": ":#{key}:"}' #{slack_hook}
      CURL
    end

    def curl_cmd
      "curl -X POST --data-urlencode"
    end

    def slack_hook
      "https://hooks.slack.com/services/YOUR/SLACK/API_KEY"
    end

    def multithreaded?
      false
    end
  end
end
