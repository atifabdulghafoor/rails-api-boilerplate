FactoryBot.define do
  factory :api_key do
    token { SecureRandom.uuid }
    app_info { { name: 'SampleApp' } }
  end
end
