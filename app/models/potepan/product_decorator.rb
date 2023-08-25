module Potepan::ProductDecorator
  def related_products
    Spree::Product.in_taxons.
      includes(master: [:default_price, :images]).
      where.not(id: id).
      distinct
  end
end
