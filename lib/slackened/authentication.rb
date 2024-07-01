# frozen_string_literal: true

require 'forwardable'

module Slackened
	# proof of concept
	module Authentication
		extend Forwardable

		# alphabetical
		def_delegators self, :validate_request

		# alphabetical
		class << self
			def validate_request(**kwargs)
				Request.new(**kwargs).valid?
			end
		end
	end
end

