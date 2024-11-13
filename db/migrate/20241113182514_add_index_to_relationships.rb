class AddIndexToRelationships < ActiveRecord::Migration[8.0]
  def change
    add_index :relationships,
    [ :member1_id, :member2_id, :types, :depth ],
    unique: true,
    name: "relationships_index"
  end
end
