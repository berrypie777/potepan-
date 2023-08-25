Spree::Product.class_eval do
  def related_products
    Spree::Product.in_taxons.
    includes(master: [:default_price, :images]).
    where.not(id: id).
    distinct
  end
end
