# frozen_string_literal: true

require_relative 'base'

module Slackened
	module BlockKit
		# proof of concept
		module Blocks
			class Actions < Slackened::BlockKit::Blocks::Base
				MAX_LENGTH = 25

				def initialize(*elements)
					raise MinimumElementsError if elements.length.zero?
					raise MaximumElementsError, "#{elements.count} can't be greater than #{MAX_LENGTH}" if elements.length > MAX_LENGTH

					set({
						type: :actions,
						elements:
					})

					self
				end
			end
		end
	end
end
