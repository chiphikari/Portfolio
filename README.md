# Seek Hobby
![スクリーンショット 2021-11-24 22 36 36](https://user-images.githubusercontent.com/88571532/143248559-0c155dd8-53d1-4fe2-b455-a9e22149227a.png)

## サイト概要
休みの日に予定がないと暇を持て余すことがあると思います。そんなときのために暇を楽しいに変えられるよう近所の隠れ観光場所・喫茶店・散歩コースや、家で楽しめる本・動画・その他趣味などいろんなユーザーから投稿された記事を参考に、お金をあまり使わずして楽しみを得られるようにする「余暇・休日の楽しみ方レビュー」サイトです。
もちろん、共有したい楽しみがあれば投稿して共有することも可能です。

## デプロイURL

### サイトテーマ
「暇すぎる？それをプチ楽しい時間に変えよう」がテーマです。
暇な時間は短い期間（１日や数時間）が多いかと思いますのでプチ時間とし、そのプチ時間を楽しいに変えようということでテーマを選びました。

### テーマを選んだ理由
サイトを利用する目的は暇な時でも楽しみたいことを見つけることです。私も含め、皆さん毎月どこかで暇な日や時間があり、一人でどうしようか悩むことがあるかと思います。
その暇な時間は1日のときもあれば数時間だったりするかもしれないのでそんな短時間の空き時間を楽しめるようGoogleMapを利用して投稿された実は近所にあったおすすめスポットに行ってみたり、
外に出たくなければ家で楽しむことができることを投稿で共有しあって探せるようにと思いました。

### ターゲットユーザ/目指した課題解決
<ターゲット>
- 休みの日に予定がないけど一人でも何かしたいユーザ
- 自分の楽しみ方や場所を共有したいユーザ
- 新しい趣味を探しているユーザ

<目指した課題解決>
その人にあった充実した休みを過ごしリフレッシュできるようにすることです。
また、一人でも休みを楽しめ、機会があればいろんな人と出会えたり新たな趣味を見つけることができると思います。

### 主な利用シーン
仕事の合間や移動などの隙間時間や、その日何も予定がない日など。また、予定がないため予定を立てようとするときなどです。

## 要件定義
| 優先順位 |  機能  |  目的  |  詳細  |
|:----|:---------------|:---------------|:---------------|
| 高 | 設計書 | アプリケーション全体像を把握するための設計図  | 下の詳細設計を参照 |
| 高 | ユーザー管理機能(devise) | ログインし記事を投稿できるようにしたり、ブックマークやいいねできるようにするため | ヘッダーにログイン・ログアウトボタンを表示 |
| 高 | ユーザー登録情報編集 | 画像追加、登録したメールアドレスとユーザー名の変更 | ヘッダーのマイページから登録している画面を表示し編集可能 |
| 高 | 投稿一覧 | 1つのページで条件分岐を用いいた画面切り替えで表示させる | プルダウン選択やURLにカテゴリーの数字を含めることで画面切り替え実施 |
| 高 | 投稿詳細 | 投稿時に記入した内容をすべて表示 | 家カテゴリーの投稿の場合リンクの情報が表示され、外カテゴリーの場合住所とGoogleMAPが表示される |
| 高 | 新規投稿 | 記事の新規投稿 | 複数テーブルをアソシエーションし、カテゴリーによって投稿する内容を一部変更 |
| 高 | 投稿編集 | 投稿した記事を編集できるようにする | 投稿詳細画面から編集ボタンを押し、投稿している情報を表示させ、変更したい内容を更新する
| 高 | 投稿削除 | 投稿した記事を削除する | 投稿詳細ページから削除ボタンをクリックし投稿内容を削除 |
| 高 | GoogleAPI | 投稿した住所を地図に表示 | 新規投稿時、入力した住所を検索し位置を確認し保存。また、投稿詳細ページにて投稿した住所と地図を表示
| 高 | 投稿一覧画面のソート順変更 | 最新の投稿一覧順といいね順にソートを変更 | プルダウンからソートしたい順番を選択し、画面のソート順を切り替える|
| 高 | 投稿一覧のカテゴリーごとの画面に切り替え | 表示したいカテゴリーごとの投稿一覧を開く | 該当のカテゴリーリンクをクリックし、投稿一覧をそのカテゴリーの表示に絞る。またその際いいね順のソートをプルダウンから選択すると切り替えも可能 |
| 中 | ユーザー退会機能 | 退会希望の際実施可能にするため | ユーザー編集ページで退会ボタンから退会できる |
| 中 | いいね機能（非同期通信） | 良かったと思う投稿に対しいいねをつけられるようにする | 投稿詳細ページにていいね登録・解除可能 |
| 中 | ブックマーク機能(非同期通信) | ブックマークしたい投稿をブックマークし、自分のページで確認できるようにする | 投稿詳細でブックマーク登録し、登録した一覧の自分のページで確認可能 |
| 中 | レビュー評価(raty.js) | 投稿された内容のレビュー可能 | 投稿詳細ページから星の点数とコメントが可能 |
| 中 | 複数画像投稿 | 複数の画像が投稿できる | 新規投稿もしくは投稿編集ページにて投稿したい写真を全選択すると投稿が可能 |
| 中 | Slick | 複数画像を5秒ごとに自動スライドさせる | 投稿一覧・投稿詳細にて投稿されて複数画像が自動スライドされる |
| 中 | kaminari＋Jscroll |ページネーションの次ページを画面スクロールで一番下に来た際表示させる | 投稿一覧ページにて1画面4つまでの投稿表示可能。次ページにも投稿がある場合はスクロール時に自動表示 |
| 中 | タグ機能 | 投稿に好きなキーワードタグをつけれる | 新規投稿・投稿編集時にタグ登録が可能 |
| 中 | 検索機能 | 特定キーワードで検索する | ヘッダー右から「タグ」か「住所」を選択し、該当のデータからキーワード検索が可能 |
| 低 | FlexBox |レイアウト調整 | |
| 低 | Bootstrap | レイアウト調整 | |



## 設計書
・ER図  https://drive.google.com/file/d/1n5QOeI7Z9MCnIkrZcWpSYCt0HPRzJxAq/view?usp=sharing
![スクリーンショット 2021-11-22 16 40 15](https://user-images.githubusercontent.com/88571532/142821942-52bc1cf2-97d4-4ad1-8c79-424ec7f12d32.png)

・ワイヤーフレーム https://drive.google.com/file/d/1j_aNyOd5E9jFWpORuLhHuX8qRQU84pkQ/view?usp=sharing
![スクリーンショット 2021-11-22 16 53 57](https://user-images.githubusercontent.com/88571532/142823600-93b80415-2b1b-4fcb-826d-0ce443834da3.png)
・アプリケーション詳細設計 https://docs.google.com/spreadsheets/d/1spP6kh7j0TylcF9Jre5CkfejLvrP9DrSqo7ZOhP1oUc/edit?usp=sharing
![スクリーンショット 2021-11-22 17 03 39](https://user-images.githubusercontent.com/88571532/142824876-2df8eea6-9f7f-4e5f-b738-7effe23b3d22.png)
・テーブル定義書  https://docs.google.com/spreadsheets/d/1TB_KNWTwi3a009Ew4AHoVYVj9CzrMl5sx56fDYFxuZw/edit?usp=sharing
![スクリーンショット 2021-11-22 17 08 28](https://user-images.githubusercontent.com/88571532/142825405-37ab34d1-f219-42f0-8c40-4d8079126240.png)


## チャレンジ要素一覧
https://docs.google.com/spreadsheets/d/1AmqxU5fNynmpNQzDK6hLPAhZ7tTsw0osOnRnEkhDmXE/edit?usp=sharing

## 開発環境
- 言語：HTML,CSS,JavaScript,Ruby,SQL
- フレームワーク：Ruby on Rails
- JSライブラリ：jQuery
- IDE：Cloud9