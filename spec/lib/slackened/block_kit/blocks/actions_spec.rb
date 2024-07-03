# frozen_string_literal: true

require './lib/slackened'

describe Slackened::BlockKit::Blocks::Actions do # rubocop:disable Metrics/BlockLength
	let(:button_a) do
		Slackened::BlockKit::Blocks::Button.new(
			plain_text: 'Click here',
			action_id: 'action-a',
			value: 'value-a'
		)
	end

	let(:button_b) do
		Slackened::BlockKit::Blocks::Button.new(
			plain_text: 'Click here',
			action_id: 'action-b',
			value: 'value-b'
		)
	end

	let(:action) { described_class.new(button_a) }

	context '.new' do
		it 'renders an action object with fields properly' do
			rendered = described_class.new(button_a, button_b).to_h

			expect(rendered[:elements].length).to eql(2)
			expect(rendered[:elements][0][:type]).to eq(:button)
			expect(rendered[:elements][1][:type]).to eq(:button)
		end

		it 'raises an error when an invalid object is passed in' do
			expect do
				described_class.new(action)
			end.to raise_error(Slackened::BlockKit::Blocks::InvalidElement)
		end
	end
end
