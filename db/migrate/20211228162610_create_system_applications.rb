class CreateSystemApplications < ActiveRecord::Migration[5.2]
  def change
    create_table :system_applications do |t|
      t.string :name, null: false
      t.string :token, null: false, unique: true, index: true
      t.string :chats_count, default: 0
      t.string :slug, unique: true, index: true
      t.bigint :ahoy_visit_id, index: true

      t.timestamps
    end
  end
end
