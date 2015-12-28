require 'optparse'

module SlackBomb
  class Options
    class << self
      def parse!
        options = {}
        OptionParser.new do |opts|

          opts.on(
            "-c",
            "--channel=CHANNEL",
            "Channel to post in. Example: bot-island, becomes #bot-island"
          ) do |c|
            options[:channel] = "#" + c
          end

          opts.on(
            "-d",
            "--dry-run",
            "Don't post to slack, just print Curl command."
          ) do
            options[:dry_run] = true
          end

          opts.on(
            "-s",
            "--sleep=SLEEP",
            "How long to wait inbetween requests."
          ) do |sleep|
            options[:sleep] = sleep.to_f
          end

          opts.on(
            "-t",
            "--multi-threaded",
            "Call to slack with multiple threads"
          ) do
            options[:multi_threaded] = true
          end

          opts.on(
            "-m",
            "--message=MESSAGE",
            "What message to bomb slack with. Defaults to random Faker catch phrase."
          ) do |message|
            options[:message] = message
          end

          opts.on(
            "-n",
            "--number=NUMBER",
            "Number of requests to be made to slack. Default: 50"
          ) do |number|
            options[:number] = number
          end

          opts.on_tail(
            "-h",
            "--help",
            "Here are all the options Slack Bomb takes"
          ) do
            puts opts
            exit
          end

        end.parse!
        options
      end
    end
  end
end
