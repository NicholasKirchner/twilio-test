class CreateMessages < ActiveRecord::Migration
  def change
    create_table :messages do |t|
      t.string :contents, limit: 140 #140 is the limit for texts, right?

      t.timestamps
    end
  end
end
