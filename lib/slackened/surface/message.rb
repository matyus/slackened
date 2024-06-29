# frozen_string_literal: true

require 'forwardable'

module Slackened
  module Surface
    # Proof of concept
    # https://api.slack.com/surfaces/messages
    class Message
      extend Forwardable
      extend Slackened::BlockKit::Blocks

      # alphabetical
      def_delegators self, :data, :build, :post

      # alphabetical
      class << self
        def data
          @data ||= Slackened::BlockKit::Data.new
        end

        def build
          yield data
        end

        def post(**kwargs)
          layout(**kwargs)

          Slackened::Commands.new.post(blocks: @data.blocks)
        end

        def layout
          raise NotImplementedError, 'You must define `self.layout` and build a layout'
        end
      end
    end
  end
end
