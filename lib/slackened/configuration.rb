# frozen_string_literal: true

module Slackened
	# Settings
	class Configuration
		# alphabetize
		attr_accessor :signing_secret, :webhook_url

		def initialize
			# alphabetize
			@signing_secret = ''
			@webhook_url = 'https://slack.com'
		end
	end
end
