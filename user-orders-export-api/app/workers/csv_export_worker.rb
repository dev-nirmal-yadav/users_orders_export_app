# app/workers/csv_export_worker.rb
require 'csv'

class CsvExportWorker
  include Sidekiq::Worker

  def perform(user_id)
    user = User.find(user_id)
    csv_data = generate_csv_data_for_user(user)
    save_csv_data(csv_data, user)
    ActionCable.server.broadcast('csv_generation_channel', {message: "#{user.username}_orders.csv is ready", username: user.username})
  end

  private

  def generate_csv_data_for_user(user)
    # Generate CSV data specific to user orders
    CSV.generate(headers: true) do |csv|
      csv << ['USERNAME', 'USER_EMAIL', 'PRODUCT_CODE', 'PRODUCT_NAME', 'PRODUCT_CATEGORY', 'ORDER_DATE']
      user.orders.each do |order|
        csv << [
          user.username,
          user.email,
          order.product.code,
          order.product.name,
          order.product.category,
          order.order_date
        ]
      end
    end
  end

  def save_csv_data(csv_data, user)
    temp_dir = Rails.root.join('tmp', 'csv')
    FileUtils.mkdir_p(temp_dir) unless File.directory?(temp_dir)
    csv_file_path = File.join(temp_dir, "#{user.username}_orders.csv")
    
    File.open(csv_file_path, 'wb') do |file|
      file.write(csv_data)
    end

    csv_file_path
  end
end
