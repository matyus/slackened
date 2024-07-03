# frozen_string_literal: true

require 'securerandom'
require './lib/slackened'

describe Slackened::BlockKit::Blocks::Section do # rubocop:disable Metrics/BlockLength
	context '.new' do
		let(:text) { 'Velma Dinkley' }
		let(:text_too_long) { SecureRandom.alphanumeric(3001) }

		it 'renders a section object with one node properly' do
			rendered = described_class.new(text).to_h
			expect(rendered[:type]).to eq(:section)
			expect(rendered.dig(:text, :text)).to be(text)
		end

		it 'renders a section object with ten nodes properly' do
			rendered = described_class.new(
				'one',
				'two',
				'three',
				'four',
				'five',
				'six',
				'seven',
				'eight',
				'nine',
				'ten'
			).to_h
			expect(rendered[:type]).to eq(:section)
			expect(rendered[:fields].length).to eql(10)
		end

		it 'raises an error when a section object has given elevent nodes' do
			expect do
				described_class.new(
					'one',
					'two',
					'three',
					'four',
					'five',
					'six',
					'seven',
					'eight',
					'nine',
					'ten',
					'eleven'
				)
			end.to raise_error(Slackened::BlockKit::Blocks::MaximumFieldsError)
		end
	end
end
