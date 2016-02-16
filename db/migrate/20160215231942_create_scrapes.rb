class CreateScrapes < ActiveRecord::Migration
  def change
    create_table :scrapes do |t|
      t.string :url
      t.string :title
      t.string :description
      t.string :page_type
      t.string :image
      t.string :locale
      t.string :site_name

      t.timestamps null: false
    end
  end
end
