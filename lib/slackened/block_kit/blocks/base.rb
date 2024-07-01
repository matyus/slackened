# frozen_string_literal: true

module Slackened
	module BlockKit
		# proof of concept
		module Blocks
			class MinimumCharactersError < StandardError; end
			class MaximumCharactersError < StandardError; end

			class MinimumFieldsError < StandardError; end
			class MaximumFieldsError < StandardError; end

			class MinimumElementsError < StandardError; end
			class MaximumElementsError < StandardError; end

			class MustBeString < StandardError; end

			class Base
				attr_accessor :block

				def set(block)
					@block = block
				end

				# recursion?
				def to_h
					@block.to_h do |key, value|
						if value.is_a?(Array)
							[key, value.map(&:to_h)]
						elsif value.is_a?(Base)
							[key, value.to_h]
						else
							[key, value]
						end
					end
				end
			end
		end
	end
end
