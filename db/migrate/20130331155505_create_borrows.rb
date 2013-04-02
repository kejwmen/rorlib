class CreateBorrows < ActiveRecord::Migration
  def change
    create_table :borrows do |t|
      t.integer :book_id
      t.integer :user_id
      t.date :date_return

      t.timestamps
    end
  end
end
