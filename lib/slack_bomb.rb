require "slack_bomb/version"
require 'optparse'
require 'faker'

module SlackBomb
  API_BUFFER = 0.02

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
        opts.on("-c", "--channel", "Channel to post in") do |c|
        end
          options[:channel] = c
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

  EMOJIS = [
    :neckbeard,
    :no_good,
    :hurtrealbad,
    :whale,
    :space_invader,
    :horse_racing,
    :bowtie,
    :stuck_out_tongue_winking_eye,
    :goberserk,
    :squirrel,
    :octopus,
    :sun_with_face,
    :boar,
    :eyes,
    :dragon_face,
    :neutral_face,
    :shit,
    :smiling_imp,
    :lips,
    :koala,
    :girl,
    :muscle,
    :dizzy_face,
    :bride_with_veil,
    :pray,
    :man,
    :speak_no_evil,
    :trollface,
    :ghost,
    :dolls,
    :octocat,
    :fish,
    :cop,
    :flushed,
    :rocket,
    :honey_pot,
    :panda_face
  ]
end
