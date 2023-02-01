namespace :bullet_train do
  namespace :audit_logs do
    desc "Install the migrations and models for the audit logs feature"
    task install: :environment do
      root_path = File.expand_path("../../../..", __FILE__)
      puts "Installing the migrations"
      `bundle exec rake bullet_train_audit_logs_engine:install:migrations`
      puts "Ensure you run `rake db:migrate` to run the new migrations.".green
      puts "Adding the Activity::Version model"
      FileUtils.mkdir_p "#{Rails.root}/app/models/activity"
      FileUtils.cp("#{root_path}/app/models/activity/version.rb", "#{Rails.root}/app/models/activity/version.rb")
      puts "The Bullet Train Audit Logs gem has now been installed.  See the docs by running:".green
      puts "  bin/super-scaffold audit_logs"
    end
  end
end
