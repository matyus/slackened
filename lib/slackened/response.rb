# frozen_string_literal: true

module Slackened
	# Post the message
	class Response
		attr_reader :url, :body, :msg, :code, :payload

		def initialize(response:, blocks:)
			@url = response.uri.to_s
			@body = response.body
			@msg = response.msg
			@code = response.code
			@payload = blocks
		end

		def ok?
			@code == "200"
		end

		def to_h
			{
				url:,
				body:,
				msg:,
				code:,
				payload:
			}
		end
	end
end
