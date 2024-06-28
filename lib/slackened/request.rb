# frozen_string_literal: true

module Slackened
  # Determine whether the incoming request is fraudulent
  class Request
    attr_reader :request, :signature, :timestamp

    def initialize(request)
      @request = request
      @timestamp = @request.headers.fetch('X-Slack-Request-Timestamp')
      @signature = @request.headers.fetch('X-Slack-Signature')
      @body = @request.raw_post
    end

    # The signature depends on the timestamp to protect against replay attacks. While you're extracting the timestamp,
    # check to make sure that the request occurred recently. In this example, we verify that the timestamp does not
    # differ from local time by more than five minutes.
    # https://api.slack.com/authentication/verifying-requests-from-slack
    def stale?
      Time.zone.at(@timestamp.to_i) > 5.minutes.ago
    end

    # Slack creates a unique string for your app and shares it with you.
    # Verify requests from Slack with confidence by verifying signatures using your signing secret.
    # https://api.slack.com/authentication/verifying-requests-from-slack
    def valid?
      return false if stale?

      sig_basestring = "v0:#{@timestamp}:#{request_body}"

      secret = Slackened::Configuration.signing_secret

      digest = OpenSSL::HMAC.hexdigest('SHA256', secret, sig_basestring)

      @signature == "v0=#{digest}"
    end
  end
end
