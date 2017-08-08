module HomeHelper
  def price_deference(prices)
    return if prices.count <= 1
    latest_price = prices.last
    if prices[-2].price > latest_price.price
      '<span class="text-primary">↓</span>'
    elsif prices[-2].price == latest_price.price
      '<span class="text-default">→</span>'
    else
      '<span class="text-danger">↑</span>'
    end
  end
end
