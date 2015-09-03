class ChangeUrlTypeInRegisteredApplications < ActiveRecord::Migration
  def change
    change_column :registered_applications, :url, :string
  end
end
