class   ImportBaseService
  require 'csv'

  attr_reader :file_path, :logger

  def self.call(file_path)
    new(file_path).call
  end

  def initialize(file_path, log_file)
    @file_path = file_path
    @logger = Logger.new(Rails.root.join("log/#{log_file}.log"))
  end

  def call
    CSV.foreach(file_path, headers: true) do |row|
      process_row(row)
    rescue => e
      logger.error("Failed to process row: #{e.message}")
    end
  end
end
