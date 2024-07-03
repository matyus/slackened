# frozen_string_literal: true

require 'forwardable'

module Slackened
	module BlockKit
		# proof of concept
		module Blocks
			extend Forwardable

			# alphabetical
			def_delegators self, :actions, :button, :context, :custom, :divider, :header, :section, :text

			# alphabetical
			class << self
				def actions(*elements)
					Actions.new(*elements)
				end

				def button(**kwargs)
					Button.new(**kwargs)
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

				def header(*args)
					Header.new(*args)
				end

				def section(*args)
					Section.new(*args)
				end

				def text(*args)
					Text.new(*args)
				end
			end
		end
	end
end
