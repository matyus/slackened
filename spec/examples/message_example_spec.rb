# frozen_string_literal: true

require './examples/message_example'

describe ExampleMessage do # rubocop:disable Metrics/BlockLength
  context '#layout' do
    let(:blocks) do
      described_class.layout(
        name: 'Velma Dinkley',
        contexts: [
          'Scooby Doo',
          'Scrappy Doo'
        ],
        body: 'Performs the job immediately. The job is not sent to the queuing adapter but directly executed by blocking the execution of others until it\'s finished.', # rubocop:disable Style/LineLength
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
      expect(blocks.map { |block| block[:type] }).to eq(%i[header context section section actions])
      expect(blocks[0][:text][:text]).to eql('Velma Dinkley')
      expect(blocks[1][:elements][0][:text]).to eq('Scooby Doo')
      expect(blocks[2][:text][:text]).to eql('Performs the job immediately. The job is not sent to the queuing adapter but directly executed by blocking the execution of others until it\'s finished.') # rubocop:disable Style/LineLength
      expect(blocks[3][:fields].length).to eq(5)
      expect(blocks[3][:fields][0][:text]).to eq('She is usually seen wearing a baggy orange turtleneck sweater,')
    end
  end
end
