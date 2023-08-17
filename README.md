# サイト概要
 DRA-MATCHは、中日ドラゴンズの熱狂的なファンのために生まれた観戦マッチングサイトです。<br>
 私自身、他県に住んでいた時、同じ中日ファンと一緒に観戦することができなくて寂しさを感じていました。<br>
 SNSで中日ファンの観戦仲間を探しても、限界があるなと感じていたとき、このサイトのアイディアが生まれました。<br>
 DRA-MATCHでは、ドラゴンズファンが集まり、観戦の約束をすることができます。<br>
 好きな選手、観戦歴などのプロフィール情報を設定して、同じ興味を持つファンを見つけることができます。<br>
 遠方に住んでいても、観戦仲間と一緒にドラゴンズの試合を楽しむことができます。


 <img width="1440" alt="スクリーンショット 2023-08-17 17 12 24" src="https://github.com/yuya0314/matching_app/assets/129703629/2e88d72b-a190-4754-a207-fb194c42a5f1">


# URL
https://dramatch-1b1caaa533d5.herokuapp.com/ <br >
画面右上のゲストログインボタンから、メールアドレスとパスワードを入力せずにログインできます。

# 使用技術
- HTML
- CSS
- JavaScript
- Bootstrap
- Ruby 2.7.4
- Ruby on Rails 6.1.7.4
- MySQL 5.7
- Docker/Docker-compose
- RSpec
- Rubocop
- GitHub

# ER図
<img width="515" alt="スクリーンショット 2023-08-17 20 36 28" src="https://github.com/yuya0314/matching_app/assets/129703629/dbfde22b-14ea-48bf-9c4b-73af3171f354">


# 機能一覧
- ユーザー登録、ログイン機能(devise)
- 管理者機能(Rails_admin)
<img width="1440" alt="スクリーンショット 2023-08-17 21 13 21" src="https://github.com/yuya0314/matching_app/assets/129703629/ceb5a5fa-afb1-481a-ad32-4fc5fee6fa24">
- イベント投稿機能
<img width="720" alt="スクリーンショット 2023-08-17 17 16 42" src="https://github.com/yuya0314/matching_app/assets/129703629/b0b18c8c-37f7-4861-9b50-ed53107164b1"><br>
<img width="720" alt="スクリーンショット 2023-08-17 17 20 02" src="https://github.com/yuya0314/matching_app/assets/129703629/e6a16f84-dec6-4d76-bdbd-b4e888257a97">
- イベント参加機能
<img width="1440" alt="スクリーンショット 2023-08-17 17 21 26" src="https://github.com/yuya0314/matching_app/assets/129703629/b400fea7-0264-47d5-92fd-d3d568f8bea9">
- DM機能
<img width="1438" alt="スクリーンショット 2023-08-17 21 11 12" src="https://github.com/yuya0314/matching_app/assets/129703629/7a97a429-427e-4b41-b702-11988a4612ef">
- ページネーション機能
- 検索機能(ransack)

# テスト
- RSpec
  - 単体テスト(model)
  - 機能テスト(request)
  - 統合テスト(feature)
