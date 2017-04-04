class Upload < ActiveRecord::Base
  attr_accessible :asset

  has_attached_file :asset,
  styles: { medium: "300x300>", thumb: "100x100" },
  default_url: "/images/:style/missing.jpg",
  url: '/system/uploads/:id/:style.:extension',
  path: ':rails_root/public:url'

  validates_attachment :asset, content_type: { content_type: ["image/jpg", "image/jpeg", "image/png", "image/gif"] }

end
