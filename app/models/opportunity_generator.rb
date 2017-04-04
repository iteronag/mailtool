require 'csv'
require 'iconv'

class OpportunityGenerator < ActiveRecord::Base
  attr_protected
  belongs_to :group
  STATUSES = ['New', 'Rejected', 'Hold', 'Mailed', 'Reminder']
  LANGUAGES = { 'english' => "English", 'french'  => "French", 'german' => "German"}
  TITLES = ["Mr","Ms", "Herr", "Frau"]

  validates :group_id, presence: true
  validates :company, presence: true
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :generated_mail_id1, :email_address => true, allow_blank: true
  validates :generated_mail_id2, :email_address => true, allow_blank: true
  validates :mail_id, :email_address => true, allow_blank: true
  validates :title, presence: true
  validates :website, presence: true, format: { with: /^[a-zA-Z0-9][a-zA-Z0-9-]{1,61}[a-zA-Z0-9](?:\.[a-zA-Z]{2,})+$/}

  validate :validate_rejection_status
  validate :validate_email_ids

  def language=(value)
    self[:language] = value.downcase
  end

  #generate mail if from first name and last name if is hr is true
  def assign_generated_mail_id
    if is_hr_or_info
      formatted_domain = website.gsub(/https:\/\/|http:\/\//, "").gsub(/www\./, "")
      fname = first_name.gsub(/\s/, "")
      lname = last_name.gsub(/\s/, "")
      self.generated_mail_id1 = fname + "." + lname + "@" + formatted_domain
      self.generated_mail_id2 = lname + "." + fname + "@" + formatted_domain
    end
  end

  def self.import(file)
    spreadsheet = open_spreadsheet(file)
    # spreadsheet = Roo::Spreadsheet.open(file)

    header = spreadsheet.row(1).collect!{|d| d.downcase.strip.gsub(/\s/, '_')}
    (2..spreadsheet.last_row).each do |i|
      row = Hash[[header, spreadsheet.row(i)].transpose]
      group = Group.find_by_name(spreadsheet.row(i)[0])
      row.delete("group")

      if group.present?
        opportunity_generator = group.opportunity_generators.new(row)
        # opportunity_generator.attributes = row.to_hash.slice(*accessible_attributes)
        opportunity_generator.phone_number = opportunity_generator.phone_number.to_s.gsub(/\.0$/, "")
        opportunity_generator.assign_generated_mail_id
        opportunity_generator.save(validate: false)
      end
    end
  end


  def self.open_spreadsheet(file)

    case File.extname(file.original_filename)
    when ".csv" then Roo::Csv.new(file.path, nil, :ignore)
    when ".xls" then Roo::Excel.new(file.path, nil, :ignore)
    when ".xlsx" then Roo::Excel.new(file.path, nil, :ignore)
    else raise "Unknown file type: #{file.original_filename}"
    end
  end

  def self.filter_conditions
    {
      "company"=>"company like '%?%'",
      "mail_id"=>"mail_id like '%?%'",
      "status"=>"opportunity_generators.status = '?'",
      "first_name"=>"first_name like '%?%'",
      "last_name"=>"last_name like '%?%'",
      "generated_mail_id1"=>"generated_mail_id1 like '%?%'",
      "generated_mail_id2"=>"generated_mail_id2 like '%?%'",
      "technology"=>"technology like '%?%'",
      "generated_from"=>"generated_date >= STR_TO_DATE('?', '%Y/%m/%d')",
      "generated_to"=>"generated_date <= STR_TO_DATE('?', '%Y/%m/%d')",
      "ageing_reminder"=>"ageing_reminder <= ?"
    }
  end

  def self.review_search(condition)
    template_query = "select max(version) as version, language, email_templates.group_id, email_templates.id from email_templates group by language, group_id"
    query = %{
      select DISTINCT(opportunity_generators.id), opportunity_generators.*, groups.name as group_name, ageing_reminder as ageing, templates.id as template_id, templates.language, templates.version  from opportunity_generators
      join groups on opportunity_generators.group_id = groups.id
      join mail_id_definitions on mail_id_definitions.group_id = groups.id
      join (#{template_query}) templates on (templates.group_id = opportunity_generators.group_id AND opportunity_generators.language = templates.language)
      where #{condition}
    }.gsub(/\s+/, " ").strip

    OpportunityGenerator.find_by_sql(query)
  end

  def self.statuses
    {
      reject: STATUSES[1],
      hold: STATUSES[2],
      mail: STATUSES[3],
      reminder: STATUSES[4]
    }
  end

  def self.languages
    LANGUAGES
  end

  def validation_messages
    {
      "Success" => "Verification completed successfully",
      "DnsQueryTimeout" => "DNS service failed to respond timeout",
      "DomainIsInexistent" => "Domain does not exist",
      "DomainIsWellKnownDea" => "Domain is a well known provider of disposable email addresses",
      "MailboxFull" => "The mail box is full.",
      "MailboxDoesNotExist" => "The mail box does not exist on the server.",
      "MailboxTemporarilyUnavailable" => "Grey listing in operation",
      "MailboxValidationTimeout" => "Timeout occurred waiting for SMTP server to respond.",
      "NoMxServersFound" => "No MX servers can be found for the domain.",
      "ServerIsCatchAll" => "SMTP server responds OK, partially validated",
      "SmtpConnectionFailure" => "TCP connection to mail (SMTP) server failed.",
      "SmtpConnectionShutdown" => "The smtp server prematurely terminated the connection.",
      "SmtpConnectionTimeout" => "Timeout occurred waiting for connection to SMTP server.",
      "SmtpConnectionRefused" => "The SMTP connection was refused by the remote server"
    }
  end

  private
  def validate_rejection_status

    [:mail_id, :generated_mail_id1, :generated_mail_id2].each do |field|
      if self[field].present?
        existing_record = OpportunityGenerator.where("status = 'Rejected' AND (mail_id = ? OR generated_mail_id1 = ? OR generated_mail_id2 = ?)", self[field], self[field], self[field])
        self.errors.add(field, "The opportunity had already rejected the Campaign. Cannot create the record") if (existing_record.present?)
      end
    end
  end

  def validate_email_ids

    [:mail_id, :generated_mail_id1, :generated_mail_id2].each do |field|
      next if ( self[field].blank? || !(self.changed.include?(field.to_s)) )
      response = JSON.parse(HTTParty.get(Rails.configuration.validator_domain + "?key=#{Rails.configuration.validator_key}&email=#{self[field]}"))

      if( response["status"] != "Ok")
        self.errors.add(field, validation_messages[response["additionalStatus"]])
      end
    end
  end
end
