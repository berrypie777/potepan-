module Potepan
  class ProductsController < ApplicationController
    def show
      max_related_products = 4
      @product = Spree::Product.find(params[:id])
      @related_products = @product.related_products.includes(master: [
        :default_price,
        :images,
      ]).limit(max_related_products)
    end
  end
end
