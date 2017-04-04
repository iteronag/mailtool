require 'emailhunter'
class MailIdDefinition < ActiveRecord::Base
  attr_protected
  VALIDATOR_DOMAIN = "https://api.emailhunter.co/v2/email-verifier"
  API_KEY = "ea1cb7cb5655fad64f7797d53772fe3cf8371f44"
  HUMANIZED_ATTRIBUTES = {
    :ageing_reminder => "Ageing reminder in days"
  }
  belongs_to :group

  validates :group_id, presence: true, uniqueness: true
  validates :from, presence: true, :email_address => true
  validates :cc, :email_address => true, allow_blank: true
  validates :bcc, :email_address => true, allow_blank: true
  validates :ageing_reminder, presence: true
  validates :ageing_reminder, numericality: { only_integer: true, greater_than: 0 }

  def self.human_attribute_name(attr, options = {})
    HUMANIZED_ATTRIBUTES[attr.to_sym] || super
  end
end
