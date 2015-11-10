require "slack_bomb/version"
require 'faker'

module SlackBomb
	class << self

		def bomb!
			loop do
				[
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
				].shuffle.each do |key|
					SlackBomb.post_to_slack(key)
				end
			end
		end

		def channel
			"#bot-island"
		end

		def post_to_slack(key)
			`curl -X POST --data-urlencode 'payload={"channel": "#{channel}", "username": "#{name}", "text": "#{Faker::Company.catch_phrase} is the right solution!", "icon_emoji": ":#{key}:"}' #{slack_hook}`
		end

		def channels
			["#development"]
		end

		def slack_hook
			"https://hooks.slack.com/services/SOMERANDOMLETERSANDNUMBERSFORYOURSLACKHOOK"
		end
	end
end

