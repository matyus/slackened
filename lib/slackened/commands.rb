# frozen_string_literal: true

require 'json'
require 'net/http'
require 'uri'

module Slackened
  # Post the message
  class Commands
    HEADERS = {
      'Content-Type' => 'application/json'
    }.freeze

    def initialize
      @slack_uri = Slackened.configuration.webhook_url
      @headers = HEADERS.merge(Slackened.configuration.headers)
    end

    def post(blocks: [], headers: {})
      body = JSON.dump({ blocks: })

      uri = URI(@slack_uri)

      puts "URI  #{uri}"
      puts "BODY #{body}"

      Net::HTTP.post(uri, body, @headers.merge(headers))
    end
  end
end
