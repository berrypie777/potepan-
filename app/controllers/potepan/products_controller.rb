module Potepan
  class ProductsController < ApplicationController
    RELATED_PRODUCTS_LIMIT = 4

    def show
      @product = Spree::Product.find(params[:id])
      @related_products = @product.related_products.includes(master: [
        :default_price,
        :images,
      ]).limit(RELATED_PRODUCTS_LIMIT)
    end
  end
end
