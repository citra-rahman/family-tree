class CreateMembers < ActiveRecord::Migration[8.0]
  def change
    create_table :members do |t|
      t.string :name, null: false
      t.string :gender, null: false
      t.datetime :birth_date, null: false
      t.datetime :death_date
      t.references :family, null: false, foreign_key: true

      t.timestamps
    end
  end
end
