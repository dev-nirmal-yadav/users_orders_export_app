# app/channels/csv_generation_channel.rb
class CsvGenerationChannel < ApplicationCable::Channel
  def subscribed
    stream_from "csv_generation_channel"
    Rails.logger.info "Subscribed to csv_generation_channel"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
    Rails.logger.info "Unsubscribed from csv_generation_channel"
  end
end
