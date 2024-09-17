# frozen_string_literal: true

require_relative 'base'

module Slackened
	module BlockKit
		# proof of concept
		module Blocks
			class Context < Slackened::BlockKit::Blocks::Base
				MAX_LENGTH = 10

				def initialize(*elements) # rubocop:disable Lint/MissingSuper
					raise MaximumElementsError, "#{elements.count} can't be greater than #{MAX_LENGTH}" if elements.length > MAX_LENGTH

					# TODO: need to allow for image
					# https://api.slack.com/reference/block-kit/blocks#context
					set({
						type: :context,
						elements: elements.map do |element|
							raise MustBeString, "#{element} must be a string" unless element.is_a? String

							Text.new(element)
						end
					})
				end
			end
		end
	end
end
