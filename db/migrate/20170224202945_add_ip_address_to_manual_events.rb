class AddIpAddressToManualEvents < ActiveRecord::Migration[5.0]
  def change
    add_column :manual_events, :ip_address, :string
  end
end
