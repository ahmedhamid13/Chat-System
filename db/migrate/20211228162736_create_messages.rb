class CreateMessages < ActiveRecord::Migration[5.2]
  def change
    create_table :messages do |t|
      t.integer :number, null: false, index: true
      t.string :slug, unique: true, index: true
      t.text :body, default: ''
      t.bigint :ahoy_visit_id, index: true
      t.references :chat, foreign_key: true

      t.timestamps
    end
  end
end
