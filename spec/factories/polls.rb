FactoryBot.define do
  factory :poll do
    sequence(:name) { |i| "Sample Pool #{i}" }
    expires_at { 1.week.from_now }

    factory :poll_with_options do
      after(:build) do |poll|
        _options = ["Option 1 of #{poll.name}", "Option 2 of #{poll.name}"]
        poll.options << build(:poll_option, name: _options.pop)
      end
    end
  end
end