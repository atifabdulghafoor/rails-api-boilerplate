require 'rails_helper'

RSpec.describe Product, type: :model do
  describe 'constants' do
    it { expect(described_class::STATUS_MAP).to eq({ active: 0, inactive: 1 }) }
    it { expect(described_class::STATUSES).to eq described_class::STATUS_MAP.values }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_presence_of(:status) }
    it { is_expected.to validate_presence_of(:description) }
    it { is_expected.to validate_length_of(:description).is_at_most(25) }
  end

  describe 'associations' do
    it { is_expected.to belong_to(:category) }
  end
end
