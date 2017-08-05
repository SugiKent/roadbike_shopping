class PriceMailer < ApplicationMailer

  def update_latest_price(user, product)
    @user = user
    @product = product
    @price = ProductPrice.where(product_id: product.id).last
    mail(to: @user.email, subject: "#{@product.name}の価格が昨日より安くなったようです！")
  end
end
