# frozen_string_literal: true

require 'timecop'
require './lib/slackened'

describe Slackened::Request do # rubocop:disable Metrics/BlockLength
  context '#stale?' do # rubocop:disable Metrics/BlockLength
    context 'within a valid window' do
      before do
        Timecop.freeze(Time.new(2024, 1, 2, 1, 1))
      end

      after do
        Timecop.return
      end

      let(:timestamp) { Time.new(2024, 1, 1, 1, 2).to_i }
      let(:signature) { 'v0=356dc4166515ffbca1619f4ad35a1097821730dd3e4cc7ce32f8a90b5f72f4ca' }
      let(:body) { JSON.load_file(File.join(__dir__, 'request_spec.json')) }

      it 'returns false when the request is more than five minutes old' do
        result = described_class.new(timestamp:, signature:, body:).stale?
        expect(result).to be false
      end
    end

    context 'outside a valid window' do
      before do
        Timecop.freeze(Time.new(2024, 1, 1, 1, 1))
      end

      after do
        Timecop.return
      end

      let(:timestamp) { Time.new(2024, 1, 2, 1, 1).to_i }
      let(:signature) { 'v0=356dc4166515ffbca1619f4ad35a1097821730dd3e4cc7ce32f8a90b5f72f4ca' }
      let(:body) { JSON.load_file(File.join(__dir__, 'request_spec.json')) }

      it 'returns true when the request is within five minutes old' do
        result = described_class.new(timestamp:, signature:, body:).stale?
        expect(result).to be true
      end
    end
  end
end
