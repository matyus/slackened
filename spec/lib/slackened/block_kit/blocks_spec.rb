# frozen_string_literal: true

require 'securerandom'

require './lib/slackened'

describe Slackened::BlockKit::Blocks do # rubocop:disable Metrics/BlockLength
  # testing a Module that's being extended:
  # https://mixandgo.com/learn/ruby/module-testing-with-rspec
  let(:dummy) { Class.new { extend Slackened::BlockKit::Blocks } }
  let(:text) { 'Velma Dinkley' }
  let(:text_too_long) { SecureRandom.alphanumeric(3001) }

  context '#header' do
    it 'renders a header object properly' do
      rendered = dummy.header(text)
      expect(rendered[:type]).to eq(:header)
      expect(rendered[:text][:type]).to eq(:plain_text)
      expect(rendered[:text][:text]).to eq(text)
    end

    it 'raises an error when the header is too long' do
      expect { dummy.header(text_too_long) }.to raise_error Slackened::BlockKit::Blocks::TooManyCharactersError
    end
  end

  context '#text' do
    it 'renders a text object properly' do
      rendered = dummy.text(text)
      expect(rendered[:text]).to eq(text)
    end

    it 'raises an error when the header is too long' do
      expect { dummy.text(text_too_long) }.to raise_error Slackened::BlockKit::Blocks::TooManyCharactersError
    end
  end

  context '#context' do # rubocop:disable Metrics/BlockLength
    it 'renders a context object properly' do
      rendered = dummy.context(
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
      )

      expect(rendered[:type]).to eq(:context)
      expect(rendered[:elements].first[:text]).to eq('one')
    end

    it 'raises_error on 11 items' do
      expect do
        dummy.context(
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
      end.to raise_error Slackened::BlockKit::Blocks::TooManyElementsError
    end
  end

  context '#section' do # rubocop:disable Metrics/BlockLength
    it 'renders 1 item' do
      rendered = dummy.section('one')

      expect(rendered[:type]).to be(:section)
      expect(rendered.dig(:text, :text)).to be('one')
    end

    it 'renders 10 items' do
      rendered = dummy.section(
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
      )

      expect(rendered[:type]).to be(:section)
      expect(rendered[:fields].length).to eql(10)
    end

    it 'raises_error on 11 items' do
      expect do
        dummy.section(
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
      end.to raise_error Slackened::BlockKit::Blocks::TooManyFieldsError
    end

    it 'raises_error on non-strings' do
      expect do
        dummy.section(
          'one',
          'two',
          300
        )
      end.to raise_error Slackened::BlockKit::Blocks::MustBeString
    end
  end
end
