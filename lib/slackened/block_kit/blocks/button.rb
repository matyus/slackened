# frozen_string_literal: true

require_relative 'base'

module Slackened
	module BlockKit
		# proof of concept
		module Blocks
			class Button < Slackened::BlockKit::Blocks::Base
				MAX_LENGTH = 75

				def initialize(plain_text:, action_id:, value:) # rubocop:disable Lint/MissingSuper, Metrics/MethodLength
					raise MinimumCharactersError if plain_text.empty?
					raise MaximumCharactersError, "#{plain_text} can't be greater than #{MAX_LENGTH}" if plain_text.length > MAX_LENGTH

					set({
						action_id:,
						text: {
							type: :plain_text,
							text: plain_text
						},
						type: :button,
						value:
					})
				end
			end
		end
	end
end
