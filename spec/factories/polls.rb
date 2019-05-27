FactoryBot.define do
  factory :poll do
    sequence(:name) { |i| "Sample Pool #{i}" }
    expires_at { 1.week.from_now }
  end
end