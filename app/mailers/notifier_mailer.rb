class NotifierMailer < ActionMailer::Base
  default from: "info@sedinfotech.ch"

  def opportunity(email_template, opportunity_generator)
    @email_template = email_template
    @name = opportunity_generator.title + " " + opportunity_generator.last_name
    tos = [opportunity_generator.mail_id, opportunity_generator.generated_mail_id1, opportunity_generator.generated_mail_id2].compact
    mail_id_definition = MailIdDefinition.where(group_id: email_template.group_id).first
    subject = mail_id_definition.subject

    from, cc, bcc = if mail_id_definition.present?
     [mail_id_definition.from, mail_id_definition.cc, mail_id_definition.bcc]
     else
      ["<info@sedinfotech.ch>", [], []]
    end

    job_title = opportunity_generator.job_title
    job_url = opportunity_generator.job_url.split("://").last.split("/").first if opportunity_generator.job_url.present?
    if subject.blank?
      subject = "Your job posting"
      subject <<  " for #{job_title}" if job_title.present?
      subject << " in #{job_url}" if job_url.present?
    end

    mail(
      from:    from,
      to:      tos,
      cc:      cc,
      bcc:     bcc,
      subject: subject,
    )
  end

end
