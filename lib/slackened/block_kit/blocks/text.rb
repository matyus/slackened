# frozen_string_literal: true

require_relative 'base'

module Slackened
	module BlockKit
		# proof of concept
		module Blocks
			class Text < Slackened::BlockKit::Blocks::Base
				MAX_LENGTH = 3000

				def initialize(markdown) # rubocop:disable Lint/MissingSuper
					if markdown.length > MAX_LENGTH
						raise MaximumCharactersError, "#{markdown.length} can't be greater than #{MAX_LENGTH}"
					end

					set({
						type: :mrkdwn,
						text: markdown
					})
				end
			end
		end
	end
end
