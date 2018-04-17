class CreateAmounts < ActiveRecord::Migration[5.1]
  def change
    create_table :amounts do |t|
      t.integer :user_id
      t.integer :currency_id
      t.float :quantity

      t.timestamps
    end
  end
end
