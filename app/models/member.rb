class Member < ApplicationRecord
  validates :name, uniqueness: true
  belongs_to :family

  enum :gender, male: "male", female: "female"

  has_many :relationships_as_member1, class_name: "Relationship", foreign_key: "member1_id"
  has_many :relationships_as_member2, class_name: "Relationship", foreign_key: "member2_id"

  has_many :spouses, -> { where(relationships: { types: "spouse" }) },
           through: :relationships_as_member1,
           source: :member2

  has_many :children, -> { where(relationships: { types: "child" }) },
           through: :relationships_as_member2,
           source: :member1

  has_many :parent_relationships, -> { where(types: "child") },
           class_name: "Relationship", foreign_key: "member1_id"

  has_many :parents, through: :parent_relationships, source: :member2

  scope :spouse_of, ->(member_id) {
    joins("INNER JOIN relationships ON members.id = relationships.member2_id OR members.id = relationships.member1_id")
      .where("relationships.types = ?", Relationship.types[:spouse])
      .where("relationships.member1_id = ? OR relationships.member2_id = ?", member_id, member_id)
  }

  scope :siblings_of, ->(member_id) {
    joins(:parents).where("members.id != ?", member_id)
  }

  scope :cousins_of, ->(member_id) {
    joins(parents: { siblings: :children })
      .where("members.id != ?", member_id)
  }

  scope :brother_in_law_of, ->(member_id) {
    joins("INNER JOIN relationships AS sibling_relationship ON members.id = sibling_relationship.member2_id")
      .joins("INNER JOIN relationships AS spouse_relationship ON spouse_relationship.member1_id = sibling_relationship.member1_id")
      .where("sibling_relationship.member1_id = ? AND sibling_relationship.types = ?", member_id, Relationship.types[:spouse])
  }

  scope :sister_in_law_of, ->(member_id) {
    joins("INNER JOIN relationships AS sibling_relationship ON members.id = sibling_relationship.member2_id")
      .joins("INNER JOIN relationships AS spouse_relationship ON spouse_relationship.member1_id = sibling_relationship.member1_id")
      .where("sibling_relationship.member1_id = ? AND sibling_relationship.types = ?", member_id, Relationship.types[:spouse])
  }

  scope :maternal_aunt, ->(member_id) {
    joins("INNER JOIN relationships AS mother_relationship ON members.id = mother_relationship.member1_id")
      .joins("INNER JOIN relationships AS aunt_relationship ON aunt_relationship.member2_id = mother_relationship.member2_id")
      .where("mother_relationship.types = ? AND aunt_relationship.types = ?", Relationship.types[:child], Relationship.types[:spouse])
  }

  scope :paternal_aunt_of, ->(member_id) {
    joins("INNER JOIN relationships AS father_relationship ON members.id = father_relationship.member1_id")
      .joins("INNER JOIN relationships AS aunt_relationship ON aunt_relationship.member2_id = father_relationship.member2_id")
      .where("father_relationship.relationship_type = ? AND aunt_relationship.relationship_type = ?", "child", "spouse")
  }

  scope :grandparents_of, ->(member_id) {
    joins("INNER JOIN relationships AS parent_relationship ON members.id = parent_relationship.member1_id")
      .joins("INNER JOIN relationships AS grandparent_relationship ON grandparent_relationship.member2_id = parent_relationship.member2_id")
      .where("grandparent_relationship.relationship_type = ?", Relationship.types[:child])
  }

  scope :nieces_and_nephews_of, ->(member_id) {
    joins("INNER JOIN relationships AS sibling_relationship ON members.id = sibling_relationship.member2_id")
      .joins("INNER JOIN relationships AS niece_nephew_relationship ON niece_nephew_relationship.member2_id = sibling_relationship.member1_id")
      .where("sibling_relationship.relationship_type = ? AND niece_nephew_relationship.relationship_type = ?", "child", "spouse")
  }

  validate :death_time_validation

  def death_time_validation
    message = "Birth date can't be greater than death date!"
    errors.add(:base, message) if death_date && (birth_date > death_date)
  end
end
