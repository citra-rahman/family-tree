class CreateRelationships < ActiveRecord::Migration[8.0]
  def change
    create_table :relationships do |t|
      t.references :member1, null: false, foreign_key: { to_table: 'members' }
      t.references :member2, null: false, foreign_key: { to_table: 'members' }
      t.string :types, null: false
      t.integer :depth, null: false

      t.timestamps
    end
  end
end
