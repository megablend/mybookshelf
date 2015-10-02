class AddDomainNameToCompanyProfiles < ActiveRecord::Migration
  def change
    add_column :company_profiles, :domain_name, :string, limit: 50
  end
end
