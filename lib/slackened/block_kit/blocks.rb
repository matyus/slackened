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
      def_delegators self, :actions, :button, :context, :divider, :header, :section, :text

      # alphabetical
      class << self
        def actions(*elements)
          max = 25

          raise TooManyElementsError, "#{elements.count} can't be greater than #{max}" if elements.length > max

          {
            type: :actions,
            elements:
          }
        end

        def button(plain_text:, action_id:) # rubocop:disable Metrics/MethodLength
          max = 75

          raise TooManyCharactersError, "#{plain_text} can't be greater than #{max}" if plain_text.length > max

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

        # avoid `context` naming collision
        def context(*elements)
          max = 10

          raise TooManyElementsError, "#{elements.count} can't be greater than #{max}" if elements.length > max

          # need to allow for image
          # https://api.slack.com/reference/block-kit/blocks#context
          raise MustBeString, 'all elements must be a string' unless elements.all? { |e| e.is_a? String }

          {
            type: :context,
            elements: elements.map { |e| text(e) }
          }
        end

        def divider
          { type: :divider }
        end

        def header(plain_text)
          max = 150

          raise TooManyCharactersError, "#{plain_text} can't be greater than #{max}" if plain_text.length > 150
          raise MustBeString unless plain_text.is_a? String

          {
            type: :header,
            text: {
              type: :plain_text, # cannot be :mrkdwn
              text: plain_text
            }
          }
        end

        def section(*fields) # rubocop:disable Metrics/MethodLength
          max = 10

          raise TooManyFieldsError, "#{fields.count} can't be greater than #{max}" if fields.length > max
          raise MustBeString unless fields.all? { |f| f.is_a? String }

          if fields.one?
            return {
              type: :section,
              text: text(fields.first)
            }
          end

          {
            type: :section,
            fields: fields.map { |f| text(f) }
          }
        end

        def text(markdown)
          max = 3000

          raise TooManyCharactersError, "#{markdown.length} can't be greater than #{max}" if markdown.length > max

          {
            type: :mrkdwn,
            text: markdown
          }
        end
      end
    end
  end
end
