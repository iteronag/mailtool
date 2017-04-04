class AddGroupIdToMailIdDefinition < ActiveRecord::Migration
  def change
    add_column :mail_id_definitions,:group_id, :integer
  end
end
