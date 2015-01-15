class CreateTransactions < ActiveRecord::Migration
  def change
    create_table :transactions do |t|
      t.timestamp :date
      t.float :sum, null: false
      t.string :reason, null: false
      t.belongs_to :expense, null: false
      t.integer :traffic, null: false

      t.timestamps
    end
  end
end
