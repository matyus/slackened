# frozen_string_literal: true

require_relative 'base'

module Slackened
	module BlockKit
		# proof of concept
		module Blocks
			class Text < Slackened::BlockKit::Blocks::Base
				MAX_LENGTH = 3000

				def initialize(markdown)
					raise TooManyCharactersError, "#{markdown.length} can't be greater than #{MAX_LENGTH}" if markdown.length > MAX_LENGTH

					set({
						type: :mrkdwn,
						text: markdown
					})

					self
				end
			end
		end
	end
end
