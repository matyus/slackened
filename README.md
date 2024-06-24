# Slackened

## Dependencies

- Setup a [Slack Incoming Webhook](https://api.slack.com/messaging/webhooks)
- Store the URL as an ENV Variable outside the repo for safety

## Getting started

1. Add `slackened` to your `Gemfile`

    ```rb
    gem 'slackened'
    ```

1. Configure the Webhook URL in an initializer

    ```rb
    Slackened.configure do |config|
        config.web_hook_url = 'https://hooks.slack.com/services/<your unique url>'
    end
    ```

1. Build a layout

    ```rb
    class PaymentFailedMessage < Slackened::BlockKit::Message
      def self.layout(payment_id:, context:)
        build do |message|
          message.row header('Payment failed!')
          message.row context(context)
          message.row section('Please do something about this: #{payment_id}")
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
                body: 'Please do something about this: #{pay}'
            )
        end
    end
    ```


## Development

1. Clone this repo

1. Install the libraries

    ```rb
    bundle install
    ```

