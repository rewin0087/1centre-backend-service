# frozen_string_literal: true

require_relative './../app/application_report'

RSpec.describe ApplicationReport do
  let(:service) { described_class.new('applications.json') }

  describe '#retrieve_trend' do
    let(:channel) { 'all' }

    subject { service.retrieve_trend(channel) }

    context 'when default filter (all)' do
      let(:expected_response) do
        {
          0 => 1, 1 => 3, 2 => 4, 3 => 3, 4 => 2, 5 => 3, 6 => 3, 7 => 2, 8 => 2, 9 => 4, 10 => 3, 11 => 4, 12 => 3,
          13 => 4, 14 => 4, 15 => 4, 16 => 2, 17 => 3, 18 => 4, 19 => 3, 20 => 3, 21 => 4, 22 => 1, 23 => 3
        }
      end

      it { expect(subject).to eq(expected_response) }
    end

    context 'when filter - sales channel' do
      let(:channel) { 'sales' }
      let(:expected_response) do
        {
          0 => 2, 1 => 2, 2 => 4, 3 => 1, 5 => 1, 6 => 1, 8 => 3, 9 => 2, 10 => 2, 11 => 2, 12 => 3, 13 => 1,
          14 => 2, 15 => 2, 16 => 2, 17 => 1, 18 => 1, 19 => 2, 20 => 2, 21 => 1, 23 => 2
        }
      end

      it { expect(subject).to eq(expected_response) }
    end

    context 'when filter - website channel' do
      let(:channel) { 'website' }
      let(:expected_response) do
        {
          0 => 1, 1 => 1, 2 => 2, 3 => 2, 4 => 1, 5 => 1, 6 => 1, 7 => 3, 8 => 1, 9 => 2, 10 => 1, 11 => 2,
          12 => 1, 13 => 2, 14 => 3, 15 => 3, 16 => 2, 17 => 1, 19 => 2, 20 => 1, 21 => 2, 22 => 1, 23 => 1
        }
      end

      it { expect(subject).to eq(expected_response) }
    end

    context 'when filter - qr channel' do
      let(:channel) { 'qr' }
      let(:expected_response) do
        {
          0 => 1, 1 => 1, 2 => 1, 3 => 1, 4 => 1, 5 => 3, 6 => 1, 7 => 1, 9 => 1, 10 => 2, 11 => 2,
          12 => 2, 13 => 2, 14 => 1, 15 => 2, 16 => 1, 17 => 1, 18 => 3, 19 => 1, 20 => 1, 21 => 2, 23 => 1
        }
      end

      it { expect(subject).to eq(expected_response) }
    end

    context 'when invalid filter - test channel' do
      let(:channel) { 'test' }
      let(:expected_response) { {} }

      it { expect(subject).to eq(expected_response) }
    end
  end
end
