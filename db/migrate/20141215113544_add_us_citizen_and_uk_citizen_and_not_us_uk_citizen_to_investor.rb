class AddUsCitizenAndUkCitizenAndNotUsUkCitizenToInvestor < ActiveRecord::Migration
  def change
    add_column :investors, :us_citizen, :boolean
    add_column :investors, :uk_citizen, :boolean
    add_column :investors, :not_us_uk_citizen, :boolean
    add_column :investors, :us_tax_purpose, :string
    add_column :investors, :us_provision_term, :boolean
    add_column :investors, :us_terms_of_service, :boolean
    add_column :investors, :uk_term1, :boolean
    add_column :investors, :uk_term2, :boolean
    add_column :investors, :uk_term3, :boolean
  end
end
