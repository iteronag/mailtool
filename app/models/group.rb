class Group < ActiveRecord::Base
  attr_protected

  has_many :email_templates, dependent: :destroy
  has_many :mail_id_definitions, dependent: :destroy
  has_many :opportunity_generators, dependent: :destroy

  validates :name, uniqueness: {message: "already taken"}
  validates :name, presence: true
  validates :description, presence: true

end
