# frozen_string_literal: true

require_relative 'base'

module Slackened
	module BlockKit
		# proof of concept
		module Blocks
			class Custom < Slackened::BlockKit::Blocks::Base
				def initialize(block) # rubocop:disable Lint/MissingSuper
					raise MustBeHash unless block.is_a? Hash

					set(block)
				end

				def to_h
					@block.to_h
				end
			end
		end
	end
end
