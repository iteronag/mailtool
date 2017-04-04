class AlterEmailTemplates < ActiveRecord::Migration
  def up
    add_column :email_templates, :new_text, :text
    add_column :email_templates, :reminder_text, :text
    change_column :email_templates, :version, :integer, :default => 0
    remove_column :email_templates, :type
    remove_column :email_templates, :description
  end

  def down
    remove_column :email_templates, :new_text
    remove_column :email_templates, :reminder_text
    add_column :email_templates, :type, :string
    add_column :email_templates, :description, :text
  end
end
