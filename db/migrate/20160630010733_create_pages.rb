class CreatePages < ActiveRecord::Migration
  def change
    create_table :pages do |t|
      t.text :html
      t.string :url
      t.boolean :exported, default: false

      t.timestamps null: false
    end
  end
end
