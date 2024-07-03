# frozen_string_literal: true

require 'securerandom'
require './lib/slackened'

describe Slackened::BlockKit::Blocks::Text do # rubocop:disable Metrics/BlockLength
	context '.new' do
		let(:text) { 'Velma Dinkley' }
		let(:text_too_long) { SecureRandom.alphanumeric(3001) }

		it 'renders a text object properly' do
			rendered = described_class.new(text).to_h
			expect(rendered[:text]).to eq(text)
		end

		it 'raises an error when the text is too long' do
			expect do
				described_class.new(text_too_long)
			end.to raise_error(Slackened::BlockKit::Blocks::MaximumCharactersError)
		end
	end
end
