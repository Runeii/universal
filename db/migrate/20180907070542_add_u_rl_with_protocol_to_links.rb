class AddURlWithProtocolToLinks < ActiveRecord::Migration[5.2]
  def change
    add_column :links, :url_with_protocol, :string
  end
end
