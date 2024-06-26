module Api
  class UsersController < ApplicationController
    before_action :set_user, only: :generate_orders_csv

    def index
      @users = User.all
      render json: @users
    end

    def generate_orders_csv
      CsvExportWorker.perform_async(@user.id)
      render json: { message: 'CSV generation started. It will be downloaded shortly.' }
    end

    def download_csv
      filename = "#{params[:username]}_orders.csv"
      file_path = Rails.root.join('tmp', 'csv', filename)
      if File.exist?(file_path)
        send_file file_path, type: 'text/csv', disposition: 'attachment'
      else
        render json: { error: 'File not found' }, status: :not_found
      end
    end

    private

    def set_user
      @user = User.find(params[:id])
    end
  end
end