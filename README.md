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

          # if you want/need to design singular blocks via BlockKit builder
          # https://app.slack.com/block-kit-builder/T6M32QL9G#%7B%22blocks%22:%5B%5D%7D
          # then use the `custom` method:
          message.row custom({
            "type": "section",
            "text": {
              "type": "mrkdwn",
              "text": "*Farmhouse Thai Cuisine*\n:star::star::star::star: 1528 reviews\n They do have some vegan options, like the roti and curry, plus they have a ton of salad stuff and noodles can be ordered without meat!! They have something for everyone here"
            },
            "accessory": {
              "type": "image",
              "image_url": "https://s3-media3.fl.yelpcdn.com/bphoto/c7ed05m9lC2EmA3Aruue7A/o.jpg",
              "alt_text": "alt text for image"
            }
          })

          message.row section("Please do something about this: #{payment_id}")
        end
      end
    end
    ```

1. Supply the variables

    ```rb
    class ExampleService
      def self.call
        response = ExampleMessage.post(
          context: Rails.env,
          payment_id: 'payment-abc-erf-123'
        )
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
  - Context
  - Custom (this is not a BlockKit component, this just lets you pass in
    anything you want)
  - Divider
  - Header
  - Section
  - Text

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

