FactoryBot.define do
  factory :event do
    date { "2023-07-09" }
    match { "MyString" }
    start_time { "2023-07-09 08:42:18" }
    location { "MyString" }
  end
end
