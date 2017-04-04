class AddSubjectToMailIdDefinition < ActiveRecord::Migration
  def change
    add_column :mail_id_definitions, :subject, :string
  end
end
