class CreatePolls < ActiveRecord::Migration[5.2]
  def change
    create_table :polls do |t|
      t.string :name
      t.datetime :created_at
      t.datetime :updated_at
      t.datetime :expires_at

      t.timestamps
    end
  end
end
