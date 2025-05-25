FactoryBot.define do
  factory :event do
    owner
    sequence(:name) { |i| "イベント名#{i}" }
    sequence(:place) { |i| "イベント会場#{i}" }
    sequence(:content) { |i| "イベント内容#{i}" }
    start_at{ rand(1..30).days.from_now }
    end_at{ start_at + rand(1..30).hours }
  end
end
