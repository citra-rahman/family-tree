class Relationship < ApplicationRecord
  belongs_to :member1, class_name: "Member"
  belongs_to :member2, class_name: "Member"

  validate :same_member
  before_save :define_depth

  enum :types,
    parent: "parent",
    aunt: "aunt",
    uncle: "uncle",
    spouse: "spouse",
    sibling: "sibling",
    inLaw: "in law",
    child: "child",
    cousin: "cousin",
    niece: "niece",
    nephew: "nephew"

   def same_member
    message = "Can't have relationship between the same member"
    errors.add(:base, message) if member1_id == member2_id
   end

   def define_depth
    self.depth = -1 if [ "parent", "uncle", "aunt" ].include? types
    self.depth = 0 if [ "spouse", "sibling", "in law", "cousin" ].include? types
    self.depth = 1 if [ "child", "niece", "nephew" ].include? types
   end
end
