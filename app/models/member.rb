class Member < ApplicationRecord
  belongs_to :family

  enum :gender, [ :male, :female ]

  validate :death_time_validation

  def death_time_validation
    errors.add(:base, "Birth date can't greater than death date") if birth_date > death_date
  end
end
