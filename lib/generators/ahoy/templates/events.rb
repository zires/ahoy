class <%= migration_class_name %> < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.references :visit

      t.integer :user_id
      t.string :user_type

      t.string :name
      t.text :properties

      t.timestamp :time
    end

    add_index :events, :visit_id
    add_index :events, [:user_id, :user_type]
    add_index :events, [:name, :time]
  end
end
