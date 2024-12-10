class CreateJoinTableProductsCollections < ActiveRecord::Migration[8.0]
  def change
    create_join_table :products, :collections do |t|
      # t.index [:product_id, :collection_id]
      # t.index [:collection_id, :product_id]
    end
  end
end
