# frozen_string_literal: true

require 'forwardable'

module Slackened
  module BlockKit
    # proof of concept
    module Blocks
      class TooManyCharactersError < StandardError; end
      class TooManyFieldsError < StandardError; end
      class TooManyElementsError < StandardError; end
      class MustBeString < StandardError; end

      extend Forwardable

      # alphabetical
      def_delegators self, :actions, :button, :contxt, :divider, :header, :section, :text

      # alphabetical
      class << self
        def actions(*elements)
          max = 25

          raise TooManyElementsError, "#{elements.count} is more than #{max}" if elements.length > max

          {
            type: :actions,
            elements:
          }
        end

        def button(plain_text:, action_id:) # rubocop:disable Metrics/MethodLength
          raise TooManyCharactersError, text if plain_text.length > 75

          {
            action_id:,
            text: {
              type: :plain_text,
              text: plain_text
            },
            type: :button,
            value: 'foo-vals'
          }
        end

        def contxt(*elements)
          raise TooManyElementsError if elements.length > 10

          # need to allow for image
          # https://api.slack.com/reference/block-kit/blocks#context
          raise MustBeString unless elements.all? { |e| e.is_a? String }

          {
            type: :context,
            elements: elements.map { |e| text(e) }
          }
        end

        def divider
          { type: :divider }
        end

        def header(plain_text)
          raise TooManyCharactersError if plain_text.length > 150
          raise MustBeString unless plain_text.is_a? String

          {
            type: :header,
            text: {
              type: :plain_text, # cannot be :mrkdwn
              text: plain_text
            }
          }
        end

        def section(*fields)
          raise TooManyFieldsError if fields.length > 10
          raise MustBeString unless fields.all? { |f| f.is_a? String }

          {
            type: :section,
            fields: fields.map { |f| text(f) }
          }
        end

        def text(markdown)
          raise TooManyCharactersError if markdown.length > 3000

          {
            type: :mrkdwn,
            text: markdown
          }
        end
      end
    end
  end
end
