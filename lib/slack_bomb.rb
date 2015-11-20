require "slack_bomb/version"
require "slack_bomb/options"
require 'yaml'
require 'faker'

module SlackBomb
  EMOJIS     = YAML.load_file("config/emojis.yml").fetch("emojis").map(&:to_sym)
  SLACK_HOOK = YAML.load_file("config/slack_hook.yml").fetch("slack_hook")
  DEFAULTS   = YAML.load_file("config/defaults.yml")

  class << self
    def bomb!
      Base.new.bomb!
    end
  end

  class Base
    def initialize
      @options = Options.parse!
    end

    def bomb!
      if multi_threaded?
        multi_threaded_slack_bomb
      else
        single_threaded_slack_bomb
      end
    end

    private

    def multi_threaded_slack_bomb
      threads = (1..number_of_requests).to_a.map do
        Thread.new { post_to_slack(EMOJIS.sample) }
        sleep sleep_time
      end.flatten
      threads.each(&:join)
    end

    def single_threaded_slack_bomb
      (1..number_of_requests).to_a.map do
        post_to_slack(EMOJIS.sample)
        sleep sleep_time
      end
    end

    def post_to_slack(key)
      puts "\e[33m"; puts full_curl(key); puts "\e[0m"
      return if dry_run?
      system full_curl(key)
    end

    def sleep_time
      @options[:sleep] || 1
    end

    def channel
      @options[:channel] || DEFAULTS["channel"]
    end

    def dry_run?
      @options[:dry_run] || false
    end

    def multi_threaded?
      @options[:multi_threaded] || false
    end

    def number_of_requests
      @options[:number] || 50
    end

    def message
      @options[:message] ||
        "#{Faker::Company.catch_phrase} is the right solution!"
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
          "text": "#{message}",\
          "icon_emoji": ":#{key}:"}' #{SLACK_HOOK}
          CURL
    end

    def curl_cmd
      "curl -X POST --data-urlencode"
    end
  end
end
