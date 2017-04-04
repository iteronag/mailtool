class NewTemplate < EmailTemplate
  # attr_accessible :description, :group_id, :status, :template_type, :version, :language

  # belongs_to :group

  # validates :group_id, presence: true
  # validates :version, uniqueness: {scope: [:template_type, :description]}
  # validates :version, presence: true
  # validates :description, presence: true
  # validates :description, uniqueness: {scope: [:template_type]}

  # before_validation :set_version, on: :create

  # private
  # def set_version
  #   latest_template = EmailTemplate.where(group_id: self.group_id, template_type: self.template_type).order("version desc").first
  #   self.version = latest_template.try(:version).to_i + 1
  # end
end
