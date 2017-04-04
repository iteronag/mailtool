class CreateOpportunityGenerators < ActiveRecord::Migration
  def change
    create_table :opportunity_generators do |t|
      t.string :company
      t.string :website
      t.string :title
      t.string :first_name
      t.string :last_name
      t.string :mail_id
      t.boolean :mail_id_status
      t.boolean :is_hr_or_info
      t.string :generated_mail_id1
      t.boolean :generated_mail_id1_status
      t.string :generated_mail_id2
      t.boolean :generated_mail_id2_status
      t.string :phone_number
      t.string :technology
      t.string :job_title
      t.string :job_requirements
      t.string :job_url
      t.string :linkedin_url
      t.date :generated_date
      t.string :status
      t.string :language
      t.integer :group_id

      t.timestamps
    end
  end
end
