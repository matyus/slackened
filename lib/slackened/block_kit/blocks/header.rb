# frozen_string_literal: true

require_relative 'base'

module Slackened
	module BlockKit
		# proof of concept
		module Blocks
			class Header < Slackened::BlockKit::Blocks::Base
				MAX_LENGTH = 150

				def initialize(plain_text) # rubocop:disable Lint/MissingSuper
					raise MaximumCharactersError, "#{plain_text} can't be greater than #{MAX_LENGTH}" if plain_text.length > MAX_LENGTH
					raise MustBeString unless plain_text.is_a? String

					set({
						type: :header,
						text: {
							type: :plain_text, # cannot be :mrkdwn
							text: plain_text
						}
					})
				end
			end
		end
	end
end
