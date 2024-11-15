class Member < ApplicationRecord
  validates :name, uniqueness: true
  belongs_to :family

  enum :gender, male: "male", female: "female"

  has_many :relationships, class_name: "Relationship", foreign_key: "member1_id"
  has_many :inverse_relationships, class_name: "Relationship", foreign_key: "member2_id"

  has_many :spouses, -> { where(relationships: { types: "spouse" }) },
           through: :relationships, source: :member2

  has_many :children, -> { where(relationships: { types: "child" }) },
           through: :inverse_relationships, source: :member1

  has_many :parents, -> { where(relationships: { types: "child" }) },
           through: :relationships, source: :member2

  has_many :siblings, -> { where(relationships: { types: "sibling" }) },
           through: :relationships, source: :member2

  scope :spouses_of, ->(member_id) {
    joins("INNER JOIN relationships ON members.id = relationships.member2_id OR members.id = relationships.member1_id")
      .where("relationships.types = ?", Relationship.types[:spouse])
      .where("relationships.member1_id = ? OR relationships.member2_id = ?", member_id, member_id)
      .where("members.id != ?", member_id)
  }

  def cousins
    parent_ids = parents.pluck(:id)
    uncle_aunt_ids = Relationship.where(member1_id: parent_ids, types: "sibling").pluck(:member2_id)
    cousin_ids = Relationship.where(member1_id: uncle_aunt_ids, types: "child").pluck(:member2_id)
    Member.where(id: cousin_ids)
  end

  def sisters_in_law
    spouse_sisters = spouses.joins(:siblings).where(gender: "female")
    sibling_wives = siblings.joins(:spouses).where(gender: "female")
    spouse_sisters.or(sibling_wives)
  end

  def brothers_in_law
    spouse_brothers = spouses.joins(:siblings).where(gender: "male")
    sibling_husbands = siblings.joins(:spouses).where(gender: "male")
    spouse_brothers.or(sibling_husbands)
  end

  def grandparents
    parent_ids = parents.pluck(:id)
    grandparent_ids = Relationship.where(member2_id: parent_ids, types: "child").pluck(:member1_id)
    Member.where(id: grandparent_ids)
  end

  validate :death_time_validation

  def death_time_validation
    message = "Birth date can't be greater than death date!"
    errors.add(:base, message) if death_date && (birth_date > death_date)
  end
end
