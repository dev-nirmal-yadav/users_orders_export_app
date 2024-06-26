class ImportUsersService < ImportBaseService
  def initialize(file_path)
    super(file_path, 'import_users')
  end

  private

  def process_row(row)
    User.find_or_create_by!(email: row['EMAIL']) do |user|
      user.username = row['USERNAME']
      user.phone = row['PHONE']
    end
  end
end
