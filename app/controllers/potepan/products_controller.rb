module Potepan
  class ProductsController < ApplicationController
    def show
      @product = Spree::Product.find(params[:id])
      @related_products = @product.related_products.includes(master: [:default_price, :images]).limit(4)
    end
  end
end
