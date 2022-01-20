class CreateActivityVersions < ActiveRecord::Migration[7.0]
  def change
    create_table :activity_versions do |t|
      t.string :item_type, null: false
      t.integer :item_id, null: false, limit: 8
      t.string :event, null: false
      t.string :whodunnit
      t.jsonb :object
      t.jsonb :object_changes

      t.references :team, foreign_key: false
      t.references :activity_versions, :action_text_rich_text, null: true, foreign_key: false

      t.datetime :created_at
    end
    add_index :activity_versions, %i[item_type item_id], name: "index_activity_versions_on_item_type_and_item_id"
  end
end
