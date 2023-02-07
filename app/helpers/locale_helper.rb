# TODO - this feels like the wrong location for this helper
# it shouldn't be in this gem. It should either be upstream it BT core
# or we should deprecate this method and use a more "modern" BT approach
module LocaleHelper
  def locale_namespace(model)
    model.class.name.pluralize.downcase.underscore
  end
end
