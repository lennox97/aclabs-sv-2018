class CreateTransactions < ActiveRecord::Migration[5.1]
  def change
    create_table :transactions do |t|
      t.integer :user_id
      t.integer :original_currency_id
      t.integer :final_currency_id
      t.float :original_currency_amount
      t.float :final_currency_amount

      t.timestamps
    end
  end
end
