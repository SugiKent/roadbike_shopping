class ProductPrice < ApplicationRecord
  belongs_to :product

  INFO_PLACE = {:wiggle_price => '.js-unit-price', :wiggle_name => '#productTitle'}

  def save_price(product)
    info = scrape_product_info(product)
    ProductPrice.create(product_id: product.id, price: info[0])
    product.update(name: info[1])
  end

  def scrape_product_info(product)
    info = []
    agent = Mechanize.new
    agent.user_agent_alias = "Mac Safari 4"
    site = agent.get(product.url)
    doc = Nokogiri::HTML(site.content.toutf8)
    # 価格を取得
    price = doc.css("#{INFO_PLACE[:wiggle_price]}").text
    # 商品名を取得
    name = doc.css("#{INFO_PLACE[:wiggle_name]}").text
    info << price.match(/¥(\S+)/)[1]
    info << name
  end

  def update_latest_price?(product)
    prices = ProductPrice.where(product_id: product.id)
    prices[-2].price > prices.last.price ? true : false
  end

  def self.crawling_price
    products = Product.all
    @product_price = ProductPrice.new
    products.each do |product|
      @product_price.save_price(product)
      if @product_price.update_latest_price?(product)
        product.user.each do |user|
          binding.pry
          PriceMailer.update_latest_price(user, product).deliver
        end
      else
        next
      end
    end
  end

end
