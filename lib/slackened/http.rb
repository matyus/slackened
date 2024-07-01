# frozen_string_literal: true

require 'forwardable'
require 'json'
require 'net/http'
require 'uri'

module Slackened
	# Post the message
	class HTTP
		extend Forwardable

		def_delegators self, :post

		HEADERS = {
			'Content-Type' => 'application/json'
		}.freeze

		class << self
			def post(blocks: [], headers: {}, url: Slackened.configuration.webhook_url)

				body = JSON.dump({ blocks: })

				uri = URI(url)

				Net::HTTP.post(uri, body, HEADERS.merge(headers))
			end
		end
	end
end
