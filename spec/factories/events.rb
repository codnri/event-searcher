FactoryBot.define do
  factory :event do
    subject "1day RoR Bootcamp"
    description "Brush up your RoR skills"
    venue "100 Queen St. W., Toronto, Ontario"
    event_date 30.day.from_now
    event_price 1299
    association :host_user
  end
end