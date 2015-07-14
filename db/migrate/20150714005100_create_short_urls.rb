class CreateShortUrls < ActiveRecord::Migration
  def change
    create_table :short_urls do |t|
      t.string :short
      t.string :long

      t.timestamps null: false
    end
  end
end
