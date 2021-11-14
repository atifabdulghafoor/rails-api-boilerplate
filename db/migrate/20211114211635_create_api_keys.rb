class CreateApiKeys < ActiveRecord::Migration[6.1]
  def change
    create_table :api_keys do |t|
      t.jsonb :app_info, default: {}
      t.string :token, null: false

      t.timestamps
    end
  end
end
