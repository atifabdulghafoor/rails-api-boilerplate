require 'rails_helper'

RSpec.describe ApiKey, type: :model do
  describe 'validations' do
    it { is_expected.to validate_presence_of(:token) }
  end
end
