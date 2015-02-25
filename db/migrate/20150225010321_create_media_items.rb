class CreateMediaItems < ActiveRecord::Migration
  def change
    create_table :media_items do |t|
      t.string :title
      t.text :description
      t.string :type
      t.integer :user_id
      t.timestamps
    end
  end
end
