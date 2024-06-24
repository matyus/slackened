# frozen_string_literal: true

# deps
require_relative 'lib/slackened'

# initializer
Slackened.configure do |config|
  config.webhook_url = ENV.fetch('SLACK_WEBHOOK_URL') { puts 'SLACK_WEBHOOK_URL is missing.' }
end

# proof of concept
class ExampleMessage < Slackened::BlockKit::Message
  def self.layout(name:, contexts:, descriptions:) # rubocop:disable Metrics/MethodLength
    build do |message|
      message.row header(name)
      message.row context(*contexts)
      message.row section(*descriptions)
      message.row actions(
        button(
          plain_text: 'Awsome',
          action_id: 'awesome-danger-1'
        )
      )
    end
  end
end

# proof of concept
class ExampleService
  def self.call # rubocop:disable Metrics/MethodLength
    response = ExampleMessage.post(
      name: 'Where aer you?',
      contexts: [
        'Scooby Doo',
        'Scrappy Doo'
      ],
      descriptions: [
        'She is usually seen wearing a baggy orange turtleneck sweater,',
        'a short red pleated skirt, knee high socks,',
        'Mary Jane shoes, and a pair of black square glasses,',
        'which she frequently loses and is unable to see without.',
        'She is seen as the "brains" of the group.'
      ]
    )

    raise StandardError, "#{response.class.name} (#{response.code}) #{response.body}" unless response.body == 'ok'
  end
end
