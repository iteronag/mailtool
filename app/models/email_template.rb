class EmailTemplate < ActiveRecord::Base
  attr_accessible :group_id, :status, :version, :language, :new_text, :reminder_text

  belongs_to :group

  validates :group_id, presence: true
  validates :version, uniqueness: {scope: [:new_text, :reminder_text], message: "Con't update version without any change"}
  validates :version, presence: true
  validates :language, presence: true
  validates :new_text, presence: true
  validates :reminder_text, presence: true

  # before_validation :set_version, on: :create
  before_create :set_version

  private
  def set_version
    latest_template = EmailTemplate.where(group_id: self.group_id, language: self.language).order("version desc").first
    self.version = latest_template.try(:version).to_i + 1
  end
end
