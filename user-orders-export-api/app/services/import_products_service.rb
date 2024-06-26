class ImportProductsService < ImportBaseService
  def initialize(filepath)
    super(filepath, 'import_products')
  end

  private

  def process_row(row)
    Product.find_or_create_by!(code: row['CODE']) do |product|
      product.name = row['NAME']
      product.category = row['CATEGORY']
    end
  end
end
