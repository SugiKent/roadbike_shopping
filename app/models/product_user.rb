class ProductUser < ApplicationRecord
  belongs_to :product
  belongs_to :user
  validates :user_id,
  uniqueness: {
    message: "すでにこの商品を登録しています。",
    scope: [:product_id]
  }

end
