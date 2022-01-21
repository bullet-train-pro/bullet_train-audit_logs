class Scaffolding::ActivityTransformer < Scaffolding::Transformer

  ACTIVITY_ASSOCIATIONS_HOOK = "# 🚅 Super Scaffolding will add new associations above"
  ERB_NEW_ACTIONS_HOOK = "<%# 🚅 super scaffolding will insert new actions above this line. %>"

  def scaffold_activity
    scaffold_add_line_to_file("./app/models/scaffolding/completely_concrete/tangible_thing.rb", "include Activity\n", CONCERNS_HOOK, prepend: true)
    scaffold_add_line_to_file("./app/models/activity/version.rb", "belongs_to :scaffolding_completely_concrete_tangible_thing, class_name: \"Scaffolding::CompletelyConcrete::TangibleThing\", optional: true\n", BELONGS_TO_HOOK, prepend: true)
    scaffold_add_line_to_file("./app/views/account/scaffolding/completely_concrete/tangible_things/show.html.erb", "<%= link_to t('global.buttons.activity'), [:activity, :account, @tangible_thing, class: first_button_primary] %>", ERB_NEW_ACTIONS_HOOK, prepend: true)
    previous_parent = child
    puts "Parents are:"
    puts parents
    parents.each do |parent|
      scaffold_add_line_to_file("./app/models/activity/version.rb", "self.#{parent.downcase} ||= #{previous_parent.downcase}&.#{parent.downcase}", ACTIVITY_ASSOCIATIONS_HOOK, prepend: true)
      previous_parent = parent
    end
    routes_manipulator = Scaffolding::RoutesFileManipulator.new("config/routes.rb", child, parent)
    routes_manipulator.add_concern(["account"], :activity)
    routes_manipulator.write
    scaffold_add_line_to_file("./app/controllers/account/scaffolding/completely_concrete/tangible_things_controller.rb", "  include ActivityActions", "class Account::Scaffolding::CompletelyConcrete::TangibleThingsController < Account::ApplicationController", increase_indent: true)
    controller_transformer = Scaffolding::ControllerTransformer.new(child, parents)
    controller_transformer.add_option_to_account_load_and_authorize_resource(member_actions: :activity)
  end

end