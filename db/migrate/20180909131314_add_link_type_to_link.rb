class AddLinkTypeToLink < ActiveRecord::Migration[5.2]
  def change
    add_column :links, :link_type, :string
  end
end
