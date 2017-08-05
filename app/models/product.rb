class Product < ApplicationRecord
  has_many :product_user
  has_many :user, through: :product_user
  has_many :product_price

  validates :url, presence: true

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
