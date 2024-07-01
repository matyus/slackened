# frozen_string_literal: true

module Slackened
	module BlockKit
		# where the blocks are stored
		class Builder
			attr_accessor :blocks

			def initialize
				@blocks = []
			end

			def row(row)
				blocks.push(row)
			end
		end
	end
end
