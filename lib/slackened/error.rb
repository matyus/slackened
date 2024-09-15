# frozen_string_literal: true

module Slackened
	class Error < StandardError
		attr_reader :response

		def initialize(http_response)
			@response = http_response

			super("#{@response.code} #{@response.message}: #{@response.body}")
		end
	end
end
