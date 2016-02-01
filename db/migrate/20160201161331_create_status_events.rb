class CreateStatusEvents < ActiveRecord::Migration
  def change
    create_table :status_events do |t|
      t.boolean :site_down
      t.text :message, null: false

      t.timestamps null: false
    end
  end
end
