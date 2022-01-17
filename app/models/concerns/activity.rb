module Activity
  extend ActiveSupport::Concern

  # define relationships.
  included do
    has_paper_trail versions: {
      class_name: "Activity::Version"
    }
    # this is because the selection criteria class names for variations are too long.
    foreign_key = (name.underscore.gsub('/', '_') + '_id').to_sym
    has_many :activity_versions, class_name: "Activity::Version", foreign_key: foreign_key
  end

end
