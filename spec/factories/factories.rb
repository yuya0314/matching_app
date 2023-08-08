FactoryBot.define do
  factory :user do
    name { '山田太郎' }
    sequence(:email) { |n| "taroyamada#{n}@example.com" }
    password { 'password' }
    self_introduction { 'よろしくお願いします！' }
    fan_years { 5 }
    favorite_player {'大島洋平'}
  end

  factory :second_user, class: User do
    name { '佐藤次郎' }
    email {  "jirosato@example.com" }
    password { 'password' }
    self_introduction { 'こちらこそよろしくお願いします！' }
    fan_years { 15 }
    favorite_player { '高橋周平' }
  end

   factory :not_registered_user, class: User do
    name { '鈴木三郎' }
    email {  "saburo@example.com" }
    password { 'password' }
    self_introduction { '最近ファンになりました！パリーグはオリックスを応援しています' }
    fan_years { 20 }
    favorite_player { '山本昌' }
  end

  factory :event do
    date { Date.today + 14.days}
    match { '巨人' }
    start_time { Time.current.change(hour: 18, min: 0) }
    location { 'バンテリンドーム' }
  end

  factory :event_listing do
    association :user
    association :event
    title { '男女問わず参加してください！' }
    message { 'ライトスタンドで一緒に熱く応援しましょう！応援歌一緒に歌える方がいいです！' }
    deadline { Date.today + 7.days }
    capacity { 3 }
    has_ticket { true }
  end

  factory :event_registration do
    association :user
    association :event_listing
    comment { 'チケットは私がまとめて購入します' }
  end
end