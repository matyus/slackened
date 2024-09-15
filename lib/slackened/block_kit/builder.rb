# frozen_string_literal: true

module Slackened
	module BlockKit
		# where the blocks are stored
		class Builder
			attr_accessor :blocks

			def initialize
				setup!
			end

			def row(row)
				blocks.push(row)
			end

			def setup!
				@blocks = []
			end
		end
	end
end
