# frozen_string_literal: true

require 'forwardable'
require_relative '../error'

module Slackened
	module Surface
		# Proof of concept
		# https://api.slack.com/surfaces/messages
		class Message
			extend Forwardable
			extend Slackened::BlockKit::Blocks

			# alphabetical
			def_delegators self, :build, :builder, :layout, :post

			# alphabetical
			class << self
				def builder
					@builder ||= Slackened::BlockKit::Builder.new
				end

				def build
					yield builder
				end

				def post(url: Slackened.configuration.webhook_url, **kwargs)
					layout(**kwargs)

					Slackened::HTTP.post(
						blocks: payload,
						url:
					)
				end

				def layout
					raise NotImplementedError, 'You must define `self.layout` and build a layout'
				end

				private

				def payload
					builder.blocks.map(&:to_h)
				end
			end
		end
	end
end
