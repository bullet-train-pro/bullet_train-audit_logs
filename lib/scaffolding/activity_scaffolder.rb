module ActivityScaffolder
  def scaffold_activity model, parent_models
    puts parent_models
    parent_models = parent_models.split(",")
    parent_models += ["Team"]
    parent_models = parent_models.map(&:classify).uniq

    transformer = Scaffolding::Transformer.new(model, parent_models)

    # It should belong to the parent instead:
    # output = `bin/rails g model #{transformer.transform_string("Scaffolding::CompletelyConcrete::TangibleThings::AppendEmojiAction" )} #{transformer.transform_string("scaffolding_completely_concrete_tangible_thing")}:references target_all:boolean target_ids:jsonb keep_receipt:boolean target_count:integer performed_count:integer created_by:references approved_by:references scheduled_for:datetime started_at:datetime completed_at:datetime sidekiq_jid:string #{attributes.join(" ")}`
    output = `bin/rails g migration #{transformer.transform_string("r g migration AddScaffoldingCompletelyConcreteTangibleThingToActivityVersion scaffolding_completely_concrete_tangible_thing:references")}`

    if output.include?("conflict") || output.include?("identical")
      puts "\n👆 No problem! Looks like you're re-running this Super Scaffolding command. We can work with the model already generated!\n".green
    end

    migration_file_name = `grep "create_table :#{transformer.transform_string("scaffolding_completely_concrete_tangible_things_append_emoji_actions")} do |t|" db/migrate/*`.split(":").first

  end

  def show_activity_help
    puts ""
    puts "🚅  usage: bin/super-scaffold activity <Model> <ParentModel[s]>"
    puts ""
    puts "E.g. to add activity to a Project model that belongs to team:"
    puts ""
    puts "  bin/super-scaffold activity Project Team"
    puts ""
    puts "E.g. to add activity to a Document model that belongs to Team through a Project"
    puts ""
    puts "  bin/super-scaffold activity Document Project,Team"
    puts ""
    puts "Give it a shot! Let us know if you have any trouble with it! ✌️"
    puts ""
    exit
  end
end