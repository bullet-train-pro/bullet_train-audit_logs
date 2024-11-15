require "scaffolding/activity_transformer"
require "scaffolding/controller_transformer"

module BulletTrain
  module AuditLogs
    module Scaffolders
      class AuditLogScaffolder < SuperScaffolding::Scaffolder

        # TODO this method was removed from the global scope in super scaffolding and moved to `Scaffolding::Transformer`,
        # but this gem hasn't been updated yet.
        def legacy_replace_in_file(file, before, after)
          puts "Replacing in '#{file}'."
          target_file_content = File.read(file)
          target_file_content.gsub!(before, after)
          File.write(file, target_file_content)
        end

        def run
          if installation_has_not_been_run?
            puts install_message
            exit
          end

          if argv.count < 2
            puts usage_message
            exit
          end

          target_model, parent_models = argv
          parent_models = parent_models.split(",")
          parent_models += ["Team"]
          parent_models = parent_models.map(&:classify).uniq

          attributes = argv[2..]

          transformer = Scaffolding::ActivityTransformer.new(target_model, parent_models)
          puts output = `bin/rails g migration #{transformer.transform_string("add_scaffolding_completely_concrete_tangible_thing_to_activity_versions scaffolding_completely_concrete_tangible_thing:references")}`

          if output.include?("conflict") || output.include?("identical")
            puts "\n👆 No problem! Looks like you're re-running this Super Scaffolding command. We can work with the migration already generated!".green
            puts "   You may need to rollback then re-run the migration named #{transformer.transform_string("add_scaffolding_completely_concrete_tangible_thing_to_activity_versions")} though.".green
          else
            puts "\nA new migration has been created. Use `bin/rails db:migrate` to run it.".green
          end

          migration_file_name = `grep "add_reference :activity_versions, :#{transformer.transform_string("scaffolding_completely_concrete_tangible_thing")}" db/migrate/*`.split(":").first
          legacy_replace_in_file(migration_file_name, "null: false", "null: true")
          legacy_replace_in_file(migration_file_name, "foreign_key: true", "foreign_key: false")

          transformer.scaffold_activity(attributes)
        end

        def usage_message
          <<~USAGE
            🚅  usage: bin/super-scaffold audit_logs <Model> <ParentModel[s]> <attribute:type> <attribute:type> ...

            E.g. to add audit_logs to a Project model that belongs to team:

              bin/super-scaffold audit_logs Project Team name:text_field

            E.g. to add audit_logs to a Document model that belongs to Team through a Project

              bin/super-scaffold audit_logs Document Project,Team name:text_field subject:text_area

            The attributes you specify will be added to the _version partial and used to show different versions of the model.

            Give it a shot! Let us know if you have any trouble with it! ✌️
          USAGE
        end

        def installation_has_not_been_run?
          !File.exist?(Rails.root.join("app/models/activity/version.rb"))
        end

        def install_message
          <<~INSTALL

            🚅  The Audit Log installer has not been run yet.

            To install it, run:

              bundle exec rake bullet_train:audit_logs:install

            Give it a shot! Let us know if you have any trouble with it! ✌️

          INSTALL
        end
      end
    end
  end
end
