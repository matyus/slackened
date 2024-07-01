# typed: false
# frozen_string_literal: true

# Slack Incoming Webhook
module Slackened
	require_relative 'slackened/authentication/request'
	require_relative 'slackened/block_kit/blocks'
	require_relative 'slackened/block_kit/blocks/actions'
	require_relative 'slackened/block_kit/blocks/button'
	require_relative 'slackened/block_kit/blocks/context'
	require_relative 'slackened/block_kit/blocks/divider'
	require_relative 'slackened/block_kit/blocks/header'
	require_relative 'slackened/block_kit/blocks/section'
	require_relative 'slackened/block_kit/blocks/text'
	require_relative 'slackened/block_kit/builder'
	require_relative 'slackened/configuration'
	require_relative 'slackened/http'
	require_relative 'slackened/logger'
	require_relative 'slackened/surface/message'

	extend Slackened::Logger

	class << self
		def configuration
			@configuration ||= Configuration.new
		end

		def configure
			yield configuration
		end
	end
end
