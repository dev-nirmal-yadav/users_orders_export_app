# This seeds Users, Products and Orders data

users_file_path = Rails.root.join('fixtures/users.csv')
ImportUsersService.call(users_file_path)
puts 'Imported Users successfully !!!'

products_file_path = Rails.root.join('fixtures/products.csv')
ImportProductsService.call(products_file_path)
puts 'Imported Products successfully !!!'

orders_file_path = Rails.root.join('fixtures/order_details.csv')
ImportOrdersService.call(orders_file_path)
puts 'Imported Order details successfully !!!'