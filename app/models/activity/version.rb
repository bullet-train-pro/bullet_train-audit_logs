class Activity::Version < PaperTrail::Version

  self.table_name = :activity_versions
  self.sequence_name = :activity_versions_id_seq

  belongs_to :team, class_name: 'Team', optional: true
  belongs_to :scaffolding_absolutely_abstract_creative_concept, class_name: 'Scaffolding::AbsolutelyAbstract::CreativeConcept', optional: true
  belongs_to :scaffolding_completely_concrete_tangible_thing, class_name: 'Scaffolding::CompletelyConcrete::TangibleThing', optional: true
  belongs_to :action_text_rich_text, class_name: 'ActionText::RichText', optional: true

  before_create do
    method = (item_type.underscore.gsub('/', '_') + '=').to_sym

    # e.g. `self.scaffolding_absolutely_abstract_creative_concept = item`
    self.send(method, item)

    if item.is_a? ActionText::RichText
      # The class of the Record that the rich text belongs to
      parent_association = item.record.class.to_s.underscore.gsub("/", "_") + "="
      # Eg scaffolding_completely_concrete_tangible_thing = item.record
      self.send(parent_association, item.record) if self.respond_to? parent_association
    end

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