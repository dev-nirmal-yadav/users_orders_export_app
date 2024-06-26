class ImportOrdersService < ImportBaseService
  def initialize(filepath)
    super(filepath, 'import_orders')
  end

  private

  def process_row(row)
    user = User.find_by(email: row['USER_EMAIL'])
    product = Product.find_by(code: row['PRODUCT_CODE'])
    create_order(user, product, row['ORDER_DATE']) if user && product
  end

  def create_order(user, product, order_date)
    Order.find_or_create_by!(user: user, product: product, order_date: order_date)
  end
end
