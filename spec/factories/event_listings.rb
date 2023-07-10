FactoryBot.define do
  factory :event_listing do
    title { "MyString" }
    message { "MyText" }
    deadline { "2023-07-09" }
    capacity { 1 }
    has_ticket { false }
  end
end
