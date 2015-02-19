class AddCountryAndUserNameToInvestor < ActiveRecord::Migration
  def change
    add_column :investors, :country, :string
    add_column :investors, :user_name, :string
  end
end
