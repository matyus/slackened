# frozen_string_literal: true

require 'forwardable'

require_relative 'slackened/block_kit/blocks'
require_relative 'slackened/block_kit/message'
require_relative 'slackened/configuration'
require_relative 'slackened/commands'

# Slack Incoming Webhook
module Slackened
  class << self
    extend Forwardable

    def_delegator :commands, :post

    def configuration
      @configuration ||= Configuration.new
    end

    def configure
      yield configuration
    end

    def commands
      @commands ||= Commands.new
    end

    def block_kit
      @block_kit ||= BlockKit.new
    end
  end
end
