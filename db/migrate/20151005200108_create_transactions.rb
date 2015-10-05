class CreateTransactions < ActiveRecord::Migration
  def change
    create_table :transactions do |t|
      t.integer :user_id
      t.string :status
      t.string :transaction_id
      t.string :amount_debit
      t.string :bank_ref_num

      t.timestamps null: false
    end
  end
end
