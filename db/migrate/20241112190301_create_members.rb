class CreateMembers < ActiveRecord::Migration[8.0]
  def change
    create_table :members do |t|
      t.string :name
      t.string :gender
      t.datetime :birth_date
      t.datetime :death_date
      t.references :family, null: false, foreign_key: true

      t.timestamps
    end
  end
end
