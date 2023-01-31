require "paper_trail"
module BulletTrain
  module AuditLogs
    class Engine < ::Rails::Engine
      # This comes from the paper_trail gem's Railtie. We need to do this because
      # when we are in a Rails engine, the Railtie is not loaded for a dependent gem
      initializer "bullet_train.audit_logs", before: "load_config_initializers" do
        ActiveSupport.on_load(:action_controller) do
          require "paper_trail/frameworks/rails/controller"
          include PaperTrail::Rails::Controller
        end

        ActiveSupport.on_load(:active_record) do
          require "paper_trail/frameworks/active_record"
        end
      end

      initializer "bullet_train.audit_logs.register_routing_concerns" do |app|
        BulletTrain.routing_concerns << proc do
          concern :activity do
            member do
              get :activity
            end
          end
        end
      end

      initializer "bullet_train.super_scaffolding.audit_logs.register_scaffolders" do |app|
        # TODO - suggested improvement to the API:
        # BulletTrain::SuperScaffolding.register_scaffolder named: "audit_logs", klass: "BulletTrain::AuditLogs::Scaffolders::AuditLogScaffolder"
        BulletTrain::SuperScaffolding.scaffolders.merge!({
          "audit_logs" => "BulletTrain::AuditLogs::Scaffolders::AuditLogScaffolder"
        })
      end
    end
  end
end
