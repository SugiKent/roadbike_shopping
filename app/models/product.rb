class Product < ApplicationRecord
  # 独自のバリデーションのために必須
  include ActiveModel::Validations

  has_many :product_user
  has_many :user, through: :product_user
  has_many :product_prices

  validates :url, presence: true
  validate do |url|
    url.allowed_url
  end

  # URLのバリデーション
  def allowed_url
    uri = URI.parse(url)
    errors.add(:url, :not_allowed) if Site.find_url_host(uri).blank?
  end


  def format_url
    if url.include?("?")
      return url.match(/(.+)\?{+}/)[1]
    else
      return url
    end
  end

  def method
    #code
  end

end
