# frozen_string_literal: true

module Slackened
  # Settings
  class Configuration
    # alphabetize
    attr_accessor :headers, :webhook_url

    def initialize
      # alphabetize
      @headers = {}
      @webhook_url = 'https://slack.com'
    end
  end
end