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


  validate :death_time_validation

  def death_time_validation
    message = "Birth date can't be greater than death date!"
    errors.add(:base, message) if death_date && (birth_date > death_date)
  end
end
