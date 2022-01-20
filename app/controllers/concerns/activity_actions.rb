module ActivityActions
  extend ActiveSupport::Concern

  def activity
    @versions = @child_object.activity_versions
    if params[:without_children]
      @versions = @versions.where(item_type: @child_object.class.to_s)
    end
    @versions = @versions.order("id DESC").limit(200).offset(params[:offset].to_i)
    @more_records = @child_object.activity_versions.count > params[:offset].to_i + 200
    @grouped_versions = @versions.group_by { |version| helpers.local_time(version.created_at).to_date }
    respond_to do |format|
      format.html { render "account/shared/activity" }
      format.js { render "account/shared/activity" }
    end
  end
end
