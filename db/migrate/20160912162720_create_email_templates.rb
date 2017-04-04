class CreateEmailTemplates < ActiveRecord::Migration
  def change
    create_table :email_templates do |t|
      t.string :language
      t.text :description
      t.string :type
      t.integer :version
      t.integer :group_id
      t.boolean :status

      t.timestamps
    end
  end
end
