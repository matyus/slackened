# frozen_string_literal: true

require './examples/message_example'

describe ExampleMessage do
  context '#layout' do
    let(:blocks) do
      described_class.layout(
        name: 'Velma Dinkley',
        contexts: [
          'Scooby Doo',
          'Scrappy Doo'
        ],
        descriptions: [
          'She is usually seen wearing a baggy orange turtleneck sweater,',
          'a short red pleated skirt, knee high socks,',
          'Mary Jane shoes, and a pair of black square glasses,',
          'which she frequently loses and is unable to see without.',
          'She is seen as the "brains" of the group.'
        ]
      )
    end

    it 'renders properly' do
      expect(blocks.map { |block| block[:type] }).to eq(%i[header context section actions])
      expect(blocks[0][:text][:text]).to eql('Velma Dinkley')
      expect(blocks[1][:elements][0][:text]).to eq('Scooby Doo')
      expect(blocks[2][:fields].length).to eq(5)
      expect(blocks[2][:fields][0][:text]).to eq('She is usually seen wearing a baggy orange turtleneck sweater,')
    end
  end
end
