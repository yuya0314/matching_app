# サイト概要
 DRA-MATCH(アプリ名)は、中日ドラゴンズの熱狂的なファンのために生まれた観戦マッチングサイトです。<br>
 私自身、他県に住んでいた時、同じ中日ファンと一緒に観戦することができなくて寂しさを感じていました。<br>
 SNSで中日ファンの観戦仲間を探しても、限界があるなと感じていたとき、このサイトのアイディアが生まれました。<br>
 DRA-MATCHでは、ドラゴンズファンが集まり、観戦の約束をすることができます。<br>
 好きな選手、観戦歴などのプロフィール情報を設定して、同じ興味を持つファンを見つけることができます。<br>
 遠方に住んでいても、観戦仲間と一緒にドラゴンズの試合を楽しむことができます。


<img width="1440" alt="スクリーンショット 2023-08-20 17 08 35" src="https://github.com/yuya0314/matching_app/assets/129703629/1de6e8f6-daed-4591-8bb8-6db55a785ed9">


# URL
https://dramatch-1b1caaa533d5.herokuapp.com/ <br >
画面右上のゲストログインボタンから、メールアドレスとパスワードを入力せずにログインできます。
- 管理者ユーザー
  - https://dramatch-1b1caaa533d5.herokuapp.com/admin
  - email: admin@mydomain
  - password: changepassword

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
<img width="682" alt="スクリーンショット 2023-08-20 17 06 37" src="https://github.com/yuya0314/matching_app/assets/129703629/d119d46c-34fd-4068-8f93-5b50a5981da5">

# 機能一覧
- ユーザー登録、ログイン機能(devise)

- 管理者機能(Rails_admin)
<img width="1440" alt="スクリーンショット 2023-08-17 21 13 21" src="https://github.com/yuya0314/matching_app/assets/129703629/ceb5a5fa-afb1-481a-ad32-4fc5fee6fa24"><br>

- 観戦イベントの募集機能
<img width="720" alt="スクリーンショット 2023-08-17 17 16 42" src="https://github.com/yuya0314/matching_app/assets/129703629/b0b18c8c-37f7-4861-9b50-ed53107164b1"><br>

<img width="720" alt="スクリーンショット 2023-08-17 17 20 02" src="https://github.com/yuya0314/matching_app/assets/129703629/e6a16f84-dec6-4d76-bdbd-b4e888257a97"><br>
- 観戦イベントの参加機能
<img width="1440" alt="スクリーンショット 2023-08-17 17 21 26" src="https://github.com/yuya0314/matching_app/assets/129703629/b400fea7-0264-47d5-92fd-d3d568f8bea9"><br>

- DM機能
<img width="1438" alt="スクリーンショット 2023-08-17 21 11 12" src="https://github.com/yuya0314/matching_app/assets/129703629/7a97a429-427e-4b41-b702-11988a4612ef"><br>

- お気に入り機能(Ajax)
<img width="1440" alt="スクリーンショット 2023-08-20 17 11 22" src="https://github.com/yuya0314/matching_app/assets/129703629/f8734ed2-b194-4959-a51b-13be583cc3ea"><br>
-　人気投稿(ランキング機能)
- ページネーション機能
- 検索機能(ransack)

# テスト
- RSpec
  - 単体テスト(model)
  - 機能テスト(request)
  - 統合テスト(feature)

# 今後の実装したいもの
- 観戦イベントごとのチャットルーム(参加者のみ)
- ユーザーの中日関わるポスト機能
- フォロー機能
