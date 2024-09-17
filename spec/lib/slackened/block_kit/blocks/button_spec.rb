# frozen_string_literal: true

require 'securerandom'
require './lib/slackened'

describe Slackened::BlockKit::Blocks::Button do
	describe '.new' do
		let(:plain_text) { 'Velma Dinkley' }
		let(:plain_text_too_long) { SecureRandom.alphanumeric(76) }
		let(:value) { 'value-1' }
		let(:action_id) { 'action-id-1' }
		let(:text_too_long) { SecureRandom.alphanumeric(3001) }

		it 'renders a button object with one node properly' do
			rendered = described_class.new(
				action_id:,
				plain_text:,
				value:
			).to_h

			expect(rendered[:type]).to eq(:button)
			expect(rendered[:action_id]).to eq(action_id)
			expect(rendered[:value]).to eq(value)
			expect(rendered.dig(:text, :text)).to eq(plain_text)
		end

		it 'raises an error if there are too many characters' do
			expect do
				described_class.new(
					action_id:,
					plain_text: plain_text_too_long,
					value:
				).to_h
			end.to raise_error(Slackened::BlockKit::Blocks::MaximumCharactersError)
		end
	end
end
