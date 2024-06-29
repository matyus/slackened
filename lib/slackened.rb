# frozen_string_literal: true

require_relative 'slackened/block_kit/blocks'
require_relative 'slackened/block_kit/data'
require_relative 'slackened/surface/message'
require_relative 'slackened/configuration'
require_relative 'slackened/commands'
require_relative 'slackened/request'

# Slack Incoming Webhook
module Slackened
  class << self
    def configuration
      @configuration ||= Configuration.new
    end

    def configure
      yield configuration
    end
  end
end
