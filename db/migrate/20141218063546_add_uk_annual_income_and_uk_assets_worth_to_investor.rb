class AddUkAnnualIncomeAndUkAssetsWorthToInvestor < ActiveRecord::Migration
  def change
    add_column :investors, :uk_annual_income, :boolean
    add_column :investors, :uk_assets_worth, :boolean
  end
end
