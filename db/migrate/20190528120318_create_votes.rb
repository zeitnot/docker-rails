class CreateVotes < ActiveRecord::Migration[5.2]
  def change
    create_table :votes, id: false do |t|
      t.references :poll, foreign_key: { on_delete: :cascade }
      t.references :poll_option, foreign_key: { on_delete: :cascade }
      t.inet :ip
      t.datetime :created_at
    end
  end
end
