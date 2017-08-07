class Site < ApplicationRecord
  validates :name, :url, :name_selector, :price_selector, presence: true

  scope :find_url_host, ->(url) { where("url LIKE '%#{url.host}%'" )   }
end
