class Activity::Version < PaperTrail::Version

  self.table_name = :activity_versions
  self.sequence_name = :activity_versions_id_seq

  belongs_to :team, class_name: 'Team', optional: true
  belongs_to :scaffolding_absolutely_abstract_creative_concept, class_name: 'Scaffolding::AbsolutelyAbstract::CreativeConcept', optional: true
  belongs_to :scaffolding_completely_concrete_tangible_thing, class_name: 'Scaffolding::CompletelyConcrete::TangibleThing', optional: true

  before_create do
    method = (item_type.underscore.gsub('/', '_') + '=').to_sym

    # e.g. `self.scaffolding_absolutely_abstract_creative_concept = item`
    self.send(method, item)

    if scaffolding_completely_concrete_tangible_thing
      self.scaffolding_absolutely_abstract_creative_concept ||= scaffolding_completely_concrete_tangible_thing.absolutely_abstract_creative_concept
    end

    if scaffolding_absolutely_abstract_creative_concept
      self.team ||= scaffolding_absolutely_abstract_creative_concept.team
    end

    # Action Text creates an additional update after creating an object
    # To avoid creating an additional Activity::Version, we check if there's any actual changes first
    # TODO - make sure changes to ActionText fields are creating versions correctly
    throw :abort if object_changes.nil?
  end

end