# frozen_string_literal: true

require 'forwardable'

module Slackened
	module BlockKit
		# proof of concept
		module Blocks
			extend Forwardable

			# alphabetical
			class << self
				def actions(*elements)
					Actions.new(*elements)
				end

				def button(**)
					Button.new(**)
				end

				def context(*elements)
					Context.new(*elements)
				end

				def custom(block)
					Custom.new(block)
				end

				def divider
					Divider.new
				end

				def header(*)
					Header.new(*)
				end

				def section(*)
					Section.new(*)
				end

				def text(*)
					Text.new(*)
				end
			end

			# alphabetical
			def_delegators self, :actions, :button, :context, :custom, :divider, :header, :section, :text
		end
	end
end
