require "paper_trail"
require "diffy"

module BulletTrain
  module AuditLogs
    class Engine < ::Rails::Engine
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

      initializer "bullet_train.audit_logs.register_template_path" do |app|
        BulletTrain::SuperScaffolding.template_paths << File.expand_path("../../../../", __FILE__)
      end
    end
  end
end
