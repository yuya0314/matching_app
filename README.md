# DRA-MATCH
 DRA-MATCHは、中日ドラゴンズの熱狂的なファンのために生まれた観戦マッチングサイトです。<br>
 私自身、長年の中日ドラゴンズファンとして、他県に住んでいた時、同じ中日ファンと一緒に観戦することができなくて寂しさを感じていました。<br>
 SNSで中日ファンの観戦仲間を探しても、限界があるなと感じていたとき、このサイトのアイディアが生まれました。<br>
 DRA-MATCHでは、中日ドラゴンズファンが集まり、観戦の約束をしたり、観戦体験を共有したりすることができます。<br>
 住んでいる地域、好きな選手、観戦歴などのプロフィール情報を設定して、同じ興味を持つファンを見つけることができます。<br>
 遠方に住んでいても、観戦仲間と一緒にドラゴンズの試合を楽しむことができます。


 <img width="1440" alt="スクリーンショット 2023-08-17 17 12 24" src="https://github.com/yuya0314/matching_app/assets/129703629/2e88d72b-a190-4754-a207-fb194c42a5f1">


# URL
https://dramatch-1b1caaa533d5.herokuapp.com/ <br >
画面右上のゲストログインボタンから、メールアドレスとパスワードを入力せずにログインできます。

# 使用技術
- Ruby 2.7.4
- Ruby on Rails 6.1.7.4
- MySQL 5.7
- Docker/Docker-compose
- RSpec
- Rubocop

# ER図
<img width="515" alt="スクリーンショット 2023-08-17 20 36 28" src="https://github.com/yuya0314/matching_app/assets/129703629/dbfde22b-14ea-48bf-9c4b-73af3171f354">


# 機能一覧
- ユーザー登録、ログイン機能(devise)
- 管理者機能
- イベント投稿機能
- イベント参加機能
- DM機能
- フォロー機能(Ajax)
- ページネーション機能
- 検索機能(ransack)

# テスト
- RSpec
  - 単体テスト(model)
  - 機能テスト(request)
  - 統合テスト(feature)
