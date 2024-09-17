# frozen_string_literal: true

require 'securerandom'
require './lib/slackened'

describe Slackened::BlockKit::Blocks::Context do
	describe '.new' do
		let(:text) { 'Velma Dinkley' }
		let(:text_too_long) { SecureRandom.alphanumeric(3001) }

		it 'renders a context object with one node properly' do
			rendered = described_class.new(text).to_h
			expect(rendered[:type]).to eq(:context)
			expect(rendered[:elements]).to be_a Array
			expect(rendered[:elements][0][:text]).to be(text)
		end

		it 'renders a context object with ten nodes properly' do
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
			expect(rendered[:type]).to eq(:context)
			expect(rendered[:elements].length).to be(10)
		end

		it 'raises an error when a context object has given elevent nodes' do
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
			end.to raise_error(Slackened::BlockKit::Blocks::MaximumElementsError)
		end
	end
end
