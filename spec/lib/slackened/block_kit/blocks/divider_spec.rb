# frozen_string_literal: true

require './lib/slackened'

describe Slackened::BlockKit::Blocks::Divider do
	describe '.new' do
		it 'renders a divider object properly' do
			expect(described_class.new.to_h).to eq({ type: :divider })
		end
	end
end
