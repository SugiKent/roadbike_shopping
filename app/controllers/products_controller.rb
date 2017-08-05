class ProductsController < ApplicationController
  after_action :scrape_product_info, only: %i(create)

  def create
    @product = Product.new()
    begin
      ActiveRecord::Base.transaction do
        # URLを整形
        product_url = Product.new(url: product_params[:url]).format_url

        # すでに同じURLの商品があるか確認
        @product = Product.where(url: product_url.encode).last
        if @product.present?
          # すでに同じURLの商品がある場合
          # ProductUser.create!(product_id: product.id, user_id: current_user.id)
        else
          # 新しい商品の場合
          @product = Product.new(url: product_url)
          @product.save!
        end
      end
    rescue
      flash[:danger] = 'ターゲット商品の登録ができませんでした。'
      redirect_to user_root_path
      return
    end

    begin
      ActiveRecord::Base.transaction do
        @product_user = ProductUser.new(product_id: @product.id, user_id: current_user.id)
        @product_user.save!
        flash[:notice] = 'ターゲット商品を登録しました。'
        redirect_to user_root_path
        return
      end
    rescue ActiveRecord::RecordInvalid
      error_messages = @product_user.errors.messages.map{|key, em| em}
      flash[:danger] = error_messages.flatten.first
      redirect_to user_root_path
      return
    rescue
      flash[:danger] = 'ターゲット商品の登録ができませんでした。'
      redirect_to user_root_path
      return
    end
  end

  private

  def product_params
    params.require(:products).permit(:url)
  end

  def scrape_product_info
    ProductPrice.new.save_price(@product)
  end
end
