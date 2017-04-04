class CreateMailIdDefinitions < ActiveRecord::Migration
  def change
    create_table :mail_id_definitions do |t|
      t.string :from
      t.string :cc
      t.string :bcc
      t.integer :ageing_reminder, default: 0

      t.timestamps
    end
  end
end
