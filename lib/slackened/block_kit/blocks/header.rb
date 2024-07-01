# frozen_string_literal: true

require_relative 'base'

module Slackened
	module BlockKit
		# proof of concept
		module Blocks
			class Header < Slackened::BlockKit::Blocks::Base
				MAX_LENGTH = 150

				def initialize(plain_text)

					raise TooManyCharactersError, "#{plain_text} can't be greater than #{MAX_LENGTH}" if plain_text.length > 150
					raise MustBeString unless plain_text.is_a? String

					set({
						type: :header,
						text: {
							type: :plain_text, # cannot be :mrkdwn
							text: plain_text
						}
					})

					self
				end
			end
		end
	end
end
