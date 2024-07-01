# frozen_string_literal: true

require 'openssl'
require 'json'

# deps
require_relative '../lib/slackened'

# initializer
Slackened.configure do |config|
  config.webhook_url = ENV.fetch('SLACK_WEBHOOK_URL') { puts 'SLACK_WEBHOOK_URL is missing.' }
  config.signing_secret = ENV.fetch('SLACK_SIGNING_SECRET') { puts 'SLACK_SIGNING_SECRET is missing.' }
end

payload = JSON.load_file('./examples/payload.json')

timestamp = '1719262409'

data = "v0:#{timestamp}:#{payload}"

puts "PAYLOAD: #{payload}"
puts "DATA:    #{data}"

puts Slackened::Request.new(
  timestamp:,
  signature: 'v0=ec64d01b232bc392a07464d98bb904ac83a40995d9bdf5de03c475ecba29dc6c',
  body: payload
).valid?
