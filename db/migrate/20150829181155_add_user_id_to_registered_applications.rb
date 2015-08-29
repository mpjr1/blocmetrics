class AddUserIdToRegisteredApplications < ActiveRecord::Migration
  def change
    add_column :registered_applications, :user_id, :integer
  end
end
