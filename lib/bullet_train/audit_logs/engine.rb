require "paper_trail"

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
    end
  end
end
