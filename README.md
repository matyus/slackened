# Slackened

<a href="https://badge.fury.io/rb/slackened"><img src="https://badge.fury.io/rb/slackened.svg" alt="Gem Version" height="18"></a>

## Dependencies

- Setup a [Slack Incoming Webhook](https://api.slack.com/messaging/webhooks)
- Optionally setup [Interactivity](https://api.slack.com/interactivity/handling)
- Store the URL as an ENV Variable outside the repo for safety

## Getting started

1. Add `slackened` to your `Gemfile`

    ```rb
    gem 'slackened'
    ```

1. Configure the Webhook URL in an initializer

    ```rb
    Slackened.configure do |config|
      config.webhook_url = ENV.fetch('SLACK_WEBHOOK_URL') { puts 'SLACK_WEBHOOK_URL is missing.' }
    end
    ```

1. Build a layout

    ```rb
    class PaymentFailedMessage < Slackened::Surface::Message
      def self.layout(payment_id:, context:)
        build do |message|
          message.row header('Payment failed!')

          message.row context(context)

          message.row section("Please do something about this: #{payment_id}")

          # NOTE:
          # if you want/need to design singular blocks via BlockKit builder
          # then use the `custom` method:

          message.row custom({
            "type": "section",
            "text": {
              "type": "mrkdwn",
              "text": "Retry the batch process"
            },
            "accessory": {
              "type": "button",
              "text": {
                "type": "plain_text",
                "text": "Retry",
                "emoji": true
              }
            }
          })
        end
      end
    end
    ```

1. Supply the variables

    ```rb
    class ExampleService
      def self.call
        # Calling .post WILL NOT raise an Error
        response = ExampleMessage.post(
          context: Rails.env,
          payment_id: 'payment-abc-erf-123'
        )

        puts response.body

        # Calling .post! WILL raise an Error
        begin
          ExampleMessage.post!(
            context: Rails.env,
            payment_id: 'payment-abc-erf-123'
          )
        rescue Slackened::Error
          puts "Fail!"
        end
      end
    end
    ```

## Interactivity

1. Enable **Interactivity & Shortcuts** for your app

    ```
    https://api.slack.com/apps/YOUR-APP-ID/interactive-messages
    ```

1. Set the `signing_secret` in an initializer

    ```rb
    Slackened.configure do |config|
      config.webhook_url = ENV.fetch('SLACK_WEBHOOK_URL') { puts 'SLACK_WEBHOOK_URL is missing.' }
      config.signing_secret = ENV.fetch('SLACK_SIGNING_SECRET') { puts 'SLACK_SIGNING_SECRET is missing.' }
    end
    ```

1. Validate that the request is real & handle the response

    ```rb
    class ExampleController < ApplicationController
      before_action :validate_request

      def response
        # Handle the request
        # https://api.slack.com/interactivity/handling#message_responses
        payload = JSON.parse(params.fetch(:payload))
        response_url = payload['response_url']

        # See the Getting Started section above for setting up a Message
        # you can override the default URL via the `post` method here...
        ExampleResponseMessage.post(
          message: 'Message received!',
          user_id: payload.dig('user', 'id'),
          url: payload['response_url']
        )

        render plain: :ok
      end

      private

      def validate_request
        # https://api.slack.com/authentication/verifying-requests-from-slack
        authentic = Slackened::Authentication.validate_request(
          timestamp: request.headers.fetch('X-Slack-Request-Timestamp'),
          signature: request.headers.fetch('X-Slack-Signature'),
          body: request.raw_post
        )

        render(plain: 'not ok', head: :unauthorized) and return unless authentic
      end
    end

## Blocks

Usable components:

  - Actions

  - Button

    ```rb
    button(
      plain_text: 'Click here',
      action_id: 'foo-1',
      value: 'foo-bar'
    )
    ```

  - Context

    ```rb
    context("#{Rails.env} | 2024-12-30")
    ```

  - Custom

    This is not a BlockKit component, it lets you pass in a single valid block
via the [BlockKit builder](https://app.slack.com/block-kit-builder)

    ```rb
    custom({
      "type": "section",
      "text": {
        "type": "mrkdwn",
        "text": "Retry the batch process"
      },
      "accessory": {
        "type": "button",
        "text": {
          "type": "plain_text",
          "text": "Retry",
          "emoji": true
        }
      }
    })
    ```

  - Divider

    ```rb
    divider
    ```

  - Header

    ```rb
    header('Hello world!')
    ```

  - Section

    ```rb
    section('Passing in a single string here creates a single column section')
    ```

    ```rb
    section(
      'Passing in multiple strings',
      'will create a two column section',
      'and you are allowed up to ten params',
      'they must all be strings'
    )
    ```

  - Text

    ```rb
    text('You may not need to use this directly, actually.')
    ```

## Surfaces

-  Message

## Security

- Authenticate responses from Slack

## TODO

- [ ] Better tests
- [ ] Add `Slackened::Surface::Modal` as per [https://api.slack.com/interactivity/handling](https://api.slack.com/interactivity/handling#modal_responses)
- [ ] More comprehensive support for all the [Blocks](https://api.slack.com/reference/block-kit/blocks)

## Development

1. Clone this repo

1. Install the libraries

    ```rb
    bundle install
    ```

