require "slack_bomb/version"
require 'optparse'
require 'yaml'
require 'faker'

module SlackBomb
  API_BUFFER = 1
  EMOJIS     = YAML.load_file("config/emojis.yml").fetch("emojis").map(&:to_sym)
  SLACK_HOOK = YAML.load_file("config/slack_hook.yml").fetch("slack_hook")

  class << self
    def bomb!
      Base.new.bomb!
    end
  end

  class Base
    def initialize
      @options = parse_options
    end

    def bomb!
      if multithreaded?
        multi_threaded_slack_bomb
      else
        single_threaded_slack_bomb
      end
    end

    private

    def multi_threaded_slack_bomb
      threads = (1..5).to_a.map do
        EMOJIS.shuffle.map do |key|
          Thread.new { post_to_slack(key) }
          sleep API_BUFFER
        end
      end.flatten
      threads.each(&:join)
    end

    def single_threaded_slack_bomb
      (1..5).to_a.map do
        EMOJIS.shuffle.map do |key|
          post_to_slack(key)
          sleep API_BUFFER
        end
      end
    end

    def post_to_slack(key)
      puts "\e[33m"; puts full_curl(key); puts "\e[0m"
      return if dry_run?
      system full_curl(key)
    end

    def channel
      @options[:channel] || "#bot-island"
    end

    def dry_run?
      @options[:dry_run] || false
    end

    def multithreaded?
      false
    end

    def parse_options
      options = {}
      OptionParser.new do |opts|

        opts.on(
          "-c",
          "--channel=CHANNEL",
          "Channel to post in. Example: bot-island, becomes #bot-island"
        ) do |c|
          options[:channel] = "#" + c
        end

        opts.on_tail("-h", "--help", "Here are all the options Slack Bomb takes") do
          puts opts
          exit
        end

        opts.on(
          "-d",
          "--dry-run", "Don't post to slack, just print Curl command."
        ) do
          options[:dry_run] = true
        end

      end.parse!
      options
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
          "icon_emoji": ":#{key}:"}' #{SLACK_HOOK}
    end

    def curl_cmd
      "curl -X POST --data-urlencode"
    end
  end
end
