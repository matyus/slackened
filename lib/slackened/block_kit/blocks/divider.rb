# frozen_string_literal: true

require_relative 'base'

module Slackened
	module BlockKit
		# proof of concept
		module Blocks
			class Divider < Slackened::BlockKit::Blocks::Base
				def initialize
					set({ type: :divider })

					self
				end

				def to_h
					@block.to_h
				end
			end
		end
	end
end
