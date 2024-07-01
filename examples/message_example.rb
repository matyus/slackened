# frozen_string_literal: true

# deps
require_relative '../lib/slackened'

# initializer
Slackened.configure do |config|
	config.webhook_url = ENV.fetch('SLACK_WEBHOOK_URL') { puts 'SLACK_WEBHOOK_URL is missing.' }
	config.signing_secret = ENV.fetch('SLACK_SIGNING_SECRET') { puts 'SLACK_SIGNING_SECRET is missing.' }
end

# proof of concept
class ExampleMessage < Slackened::Surface::Message
	def self.layout(name:, body:, contexts:, descriptions:) # rubocop:disable Metrics/MethodLength
		build do |message|
			message.row header(name)
			message.row context(*contexts)
			message.row section(body)
			message.row section(*descriptions)
			message.row actions(
				button(
					plain_text: 'Awesome',
					action_id: 'awesome-danger-1',
					value: 'value-1'
				)
			)
		end
	end
end

# proof of concept
class ExampleService
	def self.call # rubocop:disable Metrics/MethodLength
		response = ExampleMessage.post(
			name: 'Things work now',
			body: 'Performs the job immediately. The job is not sent to the queuing adapter but directly executed by blocking the execution of others until it\'s finished.', # rubocop:disable Style/LineLength
			contexts: [
				'Scooby Doo',
				'Scrappy Doo'
			],
			descriptions: [
				'She is usually seen wearing a baggy orange turtleneck sweater,',
				'a short red pleated skirt, knee high socks,',
				'Mary Jane shoes, and a pair of black square glasses,',
				'which she frequently loses and is unable to see without.',
				'She is seen as the "brains" of the group.'
			]
		)

		raise StandardError, "#{response.class.name} (#{response.code}) #{response.body}" unless response.body == 'ok'
	end
end
