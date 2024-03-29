# BulletTrain::AuditLogs

## Installation
Add this line to your application's Gemfile:

```ruby
gem "bullet_train-audit_logs"
```

And then execute:
```bash
$ bundle
```

Or install it yourself as:
```bash
$ gem install bullet_train-audit_logs
```

Run the installation rake task
```bash
$ rake bullet_train:audit_logs:install
```
This will install the migrations and add the Activity::Version model to your application

Migrate your database
```bash
bin/rails db:migrate
```

## Usage
View the usage docs from the command line by running:
```bash
$ bin/super_scaffold audit_logs
```

## Contributing
Contribution directions go here.

## License
The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
