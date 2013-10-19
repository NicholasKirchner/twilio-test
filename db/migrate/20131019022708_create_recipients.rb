class CreateRecipients < ActiveRecord::Migration
  def change
    create_table :recipients do |t|
      t.string :first_name
      t.string :phone_number
      t.references :message

      t.timestamps
    end
  end
end
