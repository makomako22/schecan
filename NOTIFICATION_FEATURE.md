# スケジュール通知機能

このドキュメントでは、開始30分前にスケジュール通知を送信する機能について説明します。

## 機能概要

- スケジュール開始の30分前（±1.5分の許容範囲）にメール通知を送信
- 既に通知が送信されたスケジュールには重複送信しない
- 日本語でのメール通知
- Rakeタスクによる定期実行

## 追加されたファイル

### モデルの変更
- `app/models/schedule.rb` - 通知ロジックの追加
- `db/migrate/20250806071355_add_notification_sent_to_schedules.rb` - notification_sentフィールドの追加

### メーラー
- `app/mailers/schedule_notification_mailer.rb` - 通知メール送信
- `app/views/schedule_notification_mailer/notification_email.text.erb` - メールテンプレート

### Rakeタスク
- `lib/tasks/schedule_notifications.rake` - 定期実行用タスク

### テスト
- `test/models/schedule_test.rb` - Scheduleモデルのテスト
- `test/mailers/schedule_notification_mailer_test.rb` - メーラーのテスト

## 使用方法

### 1. データベースマイグレーション
```bash
bundle exec rake db:migrate
```

### 2. メール設定
`config/environments/production.rb`でSMTP設定を行ってください:

```ruby
config.action_mailer.delivery_method = :smtp
config.action_mailer.smtp_settings = {
  address: 'smtp.example.com',
  port: 587,
  domain: 'yourdomain.com',
  user_name: 'your-email@yourdomain.com',
  password: 'your-password',
  authentication: 'plain',
  enable_starttls_auto: true
}
```

### 3. 手動実行
通知を手動で送信する場合:
```bash
bundle exec rake schedule:send_notifications
```

### 4. 定期実行（Cron）
Cronで5分おきに実行する設定例:
```cron
*/5 * * * * cd /path/to/schecan && bundle exec rake schedule:send_notifications
```

## メール内容

送信されるメールには以下の情報が含まれます:
- 学生の氏名・氏名（カナ）
- スケジュール日時
- 拠点名
- メンター名
- メモ（ある場合）

## API

### Scheduleモデルに追加されたメソッド

#### `should_send_notification?`
通知を送信すべきかどうかを判定します。

#### `send_notification!`
通知を送信し、`notification_sent`を`true`に更新します。

#### `Schedule.needing_notification`
通知が必要なスケジュールの一覧を取得します。

## テスト

テストを実行する場合:
```bash
bundle exec rake test
```

特定のテストファイルのみ実行:
```bash
bundle exec rake test test/models/schedule_test.rb
bundle exec rake test test/mailers/schedule_notification_mailer_test.rb
```

## 注意事項

- メーラーでは現在、メンター名に`@example.com`を付加してメールアドレスとしています。実際の運用では、ユーザーテーブルと連携してメールアドレスを取得するよう変更が必要です。
- タイムゾーンはconfig/application.rbで'Tokyo'に設定されています。
- 通知は一度だけ送信され、`notification_sent`フラグで重複送信を防いでいます。