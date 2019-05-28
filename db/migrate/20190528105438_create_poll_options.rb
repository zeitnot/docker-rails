class CreatePollOptions < ActiveRecord::Migration[5.2]
  def change
    create_table :poll_options do |t|
      t.references :poll, foreign_key: { on_delete: :cascade }
      t.string :name
    end
  end
end
